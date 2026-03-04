import asyncio
import json
from datetime import datetime, timezone
from typing import Optional

import cv2
from bson import ObjectId

from app.ai.detector import run_frame
from app.ai.redis_state import (
    push_detection,
    get_stable_state,
    get_confirmed_state,
    set_confirmed_state,
)
from app.core.database import db, update_camera_status, get_inference_settings
from app.core.redis import redis_cache
from app.core.logging import logger
from app.core.utils import get_internal_rtsp_url

_INFERENCE_INTERVAL = 0.15


class InferenceManager:
    """Singleton that owns one asyncio.Task per camera."""

    def __init__(self):
        self._tasks: dict[str, asyncio.Task] = {}

    async def start_all(self) -> None:
        settings_obj = await get_inference_settings()
        if not settings_obj.global_inference_enabled:
            logger.info("Global inference is disabled - skipping.")
            return

        cameras_cursor = db.client["parkflow"].cameras.find({"deleted_at": None})
        cameras = await cameras_cursor.to_list(length=500)

        started = 0
        for camera in cameras:
            camera_id = str(camera["_id"])

            # Check for slot mappings
            count = await db.client["parkflow"].camera_slot_mappings.count_documents(
                {"camera_id": camera_id, "deleted_at": None}
            )
            if count == 0:
                continue

            if camera_id in self._tasks and not self._tasks[camera_id].done():
                logger.info("Inference already running for camera_id={}", camera_id)
                continue

            task = asyncio.create_task(
                self._run_inference(camera_id),
                name=f"inference-{camera_id}",
            )
            self._tasks[camera_id] = task
            started += 1
            logger.info("Started background inference for camera_id={}", camera_id)

        logger.info("InferenceManager: started {} camera task(s).", started)

    async def stop_all(self) -> None:
        """Cancel all running inference tasks."""
        count = 0
        for camera_id, task in list(self._tasks.items()):
            if not task.done():
                task.cancel()
                count += 1
                logger.info("Cancelled inference task for camera_id={}", camera_id)
        self._tasks.clear()
        logger.info("InferenceManager: stopped {} camera task(s).", count)

    def is_running(self, camera_id: str) -> bool:
        task = self._tasks.get(camera_id)
        return task is not None and not task.done()

    def running_camera_ids(self) -> list[str]:
        return [cid for cid, t in self._tasks.items() if not t.done()]

    async def _run_inference(self, camera_id: str) -> None:
        try:
            oid = ObjectId(camera_id)
        except Exception:
            oid = None

        camera = None
        if oid is not None:
            camera = await db.client["parkflow"].cameras.find_one(
                {"_id": oid, "deleted_at": None}
            )
        if not camera:
            logger.warning(
                "InferenceManager: camera_id={} not found – aborting.", camera_id
            )
            return

        rtsp_url: str = camera.get("rtsp_url", "")
        if not rtsp_url:
            logger.warning(
                "InferenceManager: camera_id={} has no RTSP URL – aborting.", camera_id
            )
            return

        cursor = db.client["parkflow"].camera_slot_mappings.find(
            {"camera_id": camera_id, "deleted_at": None}
        )
        mappings = await cursor.to_list(length=200)

        if not mappings:
            logger.info(
                "InferenceManager: no slot mappings for camera_id={} – aborting.",
                camera_id,
            )
            return

        rtsp_url = get_internal_rtsp_url(rtsp_url)
        settings_obj = await get_inference_settings()

        cap = cv2.VideoCapture(rtsp_url)
        if not cap.isOpened():
            logger.error(
                "InferenceManager: could not open RTSP stream for camera_id={}",
                camera_id,
            )
            return

        cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)
        await update_camera_status(camera_id, True)

        frame_count = 0
        frame_skip = settings_obj.frame_skip
        stability_buffer = settings_obj.stability_buffer
        redis = redis_cache.client

        logger.info(
            "InferenceManager: inference loop started for camera_id={}", camera_id
        )

        try:
            while True:
                # Drain buffer, get latest frame
                for _ in range(4):
                    cap.grab()
                ret, frame = cap.retrieve()
                if not ret:
                    logger.warning(
                        "InferenceManager: lost frame for camera_id={}, retrying...",
                        camera_id,
                    )
                    await asyncio.sleep(1.0)
                    cap.release()
                    cap = cv2.VideoCapture(rtsp_url)
                    cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)
                    continue

                frame_count += 1
                if frame_skip > 1 and frame_count % frame_skip != 0:
                    await asyncio.sleep(0)
                    continue

                frame_result = await asyncio.get_event_loop().run_in_executor(
                    None,
                    run_frame,
                    frame,
                    mappings,
                    settings_obj.confidence_threshold,
                    settings_obj.iou_threshold,
                )

                now_ts = datetime.now(timezone.utc)

                for hit in frame_result.slot_hits:
                    m_id = hit.mapping_id
                    current_raw_state = hit.is_occupied

                    await push_detection(
                        redis, camera_id, m_id, current_raw_state, buffer_size=30
                    )

                    stable_state = await get_stable_state(
                        redis, camera_id, m_id, threshold=stability_buffer
                    )

                    confirmed_state = await get_confirmed_state(redis, camera_id, m_id)

                    if stable_state is not None and stable_state != confirmed_state:
                        await set_confirmed_state(redis, camera_id, m_id, stable_state)

                        from app.api.routers.parking import _update_logical_slot_status

                        await db.client["parkflow"].camera_slot_mappings.update_one(
                            {"_id": ObjectId(m_id)},
                            {
                                "$set": {
                                    "is_occupied": stable_state,
                                    "updated_at": now_ts,
                                }
                            },
                        )
                        await _update_logical_slot_status(hit.slot_id)

                        await db.client["parkflow"].occupancy_logs.insert_one(
                            {
                                "slot_id": hit.slot_id,
                                "mapping_id": m_id,
                                "event_type": (
                                    "check-in" if stable_state else "check-out"
                                ),
                                "confidence_score": next(
                                    (
                                        d.confidence
                                        for d in frame_result.detections
                                        if stable_state
                                    ),
                                    1.0,
                                ),
                                "created_at": now_ts,
                            }
                        )

                await asyncio.sleep(_INFERENCE_INTERVAL)

        except asyncio.CancelledError:
            logger.info("InferenceManager: task cancelled for camera_id={}", camera_id)
        finally:
            cap.release()
            await update_camera_status(camera_id, False)
            logger.info(
                "InferenceManager: released RTSP capture for camera_id={}", camera_id
            )


inference_manager = InferenceManager()
