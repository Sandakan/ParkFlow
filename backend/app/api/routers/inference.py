import asyncio
import json
from datetime import datetime, timezone
from typing import Any, AsyncGenerator

import cv2
from bson import ObjectId
from fastapi import APIRouter, Depends, File, HTTPException, Request, UploadFile
from fastapi.responses import StreamingResponse
from sse_starlette.sse import EventSourceResponse

from app.ai.detector import run_frame
from app.ai.inference import process_parking_image
from app.ai.stream_manager import ParkingStreamManager
from app.api.deps import get_current_user
from app.core.database import db, update_camera_status
from app.core.logging import logger
from app.core.utils import get_internal_rtsp_url
from app.models.parking_lot import ParkingLotInDB
from app.models.parking_slot import ParkingSlotInDB
from app.schemas.response import APIResponse, ResponseCode

router = APIRouter()

_INFERENCE_INTERVAL = 0.35


@router.post("/image", response_model=APIResponse[dict])
async def process_image(
    lot_id: str,
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user),
):
    """Upload a single image; returns occupancy statistics via YOLO inference."""
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image")

    image_bytes = await file.read()

    cursor = db.client["parkflow"].parking_slots.find(
        {"lot_id": lot_id, "deleted_at": None}
    )
    slots = await cursor.to_list(length=1000)

    if not slots:
        return APIResponse.error_response(
            code=ResponseCode.NOT_FOUND,
            message="No parking slots found for this lot ID. Please define slots first.",
            status_code=404,
        )

    occupancy_data, annotated_image = process_parking_image(image_bytes, slots)

    if "error" in occupancy_data:
        return APIResponse.error_response(
            code=ResponseCode.INTERNAL_SERVER_ERROR,
            message=f"AI Inference failed: {occupancy_data['error']}",
            status_code=500,
        )

    return APIResponse.success_response(
        message="Image processed successfully", data=occupancy_data
    )


@router.get("/stream/raw/{lot_id}")
async def stream_raw(lot_id: str):
    """Raw (unprocessed) MJPEG feed for a lot."""
    camera = await db.client["parkflow"].cameras.find_one(
        {"lot_id": lot_id, "deleted_at": None}
    )
    if not camera or "rtsp_url" not in camera:
        raise HTTPException(
            status_code=404, detail="No active camera or stream URL found for this lot"
        )

    rtsp_url = get_internal_rtsp_url(camera["rtsp_url"])
    return StreamingResponse(
        ParkingStreamManager.stream_raw_video(rtsp_url),
        media_type="multipart/x-mixed-replace; boundary=frame",
    )


@router.get("/stream/processed/{lot_id}")
async def stream_processed(lot_id: str):
    """YOLO-annotated MJPEG feed for a lot."""
    camera = await db.client["parkflow"].cameras.find_one(
        {"lot_id": lot_id, "deleted_at": None}
    )
    if not camera or "rtsp_url" not in camera:
        raise HTTPException(
            status_code=404, detail="No active camera or stream URL found for this lot"
        )

    cursor = db.client["parkflow"].parking_slots.find(
        {"lot_id": lot_id, "deleted_at": None}
    )
    slots = await cursor.to_list(length=1000)

    if not slots:
        raise HTTPException(
            status_code=404, detail="No parking slots defined for this lot"
        )

    rtsp_url = get_internal_rtsp_url(camera["rtsp_url"])
    return StreamingResponse(
        ParkingStreamManager.stream_processed_video(rtsp_url, slots),
        media_type="multipart/x-mixed-replace; boundary=frame",
    )


async def _detection_stream(
    camera_id: str, request: Request
) -> AsyncGenerator[dict, None]:
    """
    Reads frames from the camera RTSP stream, runs YOLO inference via a thread
    executor, performs Shapely overlap checks against slot mappings, and yields
    SSE-compatible dicts until the client disconnects.
    """
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
        camera = await db.client["parkflow"].cameras.find_one(
            {"_id": camera_id, "deleted_at": None}
        )
    if not camera:
        logger.warning("SSE stream requested for unknown camera_id={}", camera_id)
        yield {"event": "error", "data": json.dumps({"error": "Camera not found"})}
        return

    rtsp_url: str = camera.get("rtsp_url", "")
    if not rtsp_url:
        yield {
            "event": "error",
            "data": json.dumps({"error": "Camera has no RTSP URL"}),
        }
        return

    cursor = db.client["parkflow"].camera_slot_mappings.find(
        {"camera_id": camera_id, "deleted_at": None}
    )
    mappings = await cursor.to_list(length=200)

    if not mappings:
        logger.info("No slot mappings found for camera_id={}. Closing SSE.", camera_id)
        yield {
            "event": "error",
            "data": json.dumps(
                {"error": "No slot mappings configured for this camera"}
            ),
        }
        return

    rtsp_url = get_internal_rtsp_url(rtsp_url)
    logger.info(
        "Starting AI detection stream for camera_id={} ({} mappings) from {}",
        camera_id,
        len(mappings),
        rtsp_url,
    )

    cap = cv2.VideoCapture(rtsp_url)
    if not cap.isOpened():
        logger.error("Could not open RTSP stream: {}", rtsp_url)
        yield {
            "event": "error",
            "data": json.dumps({"error": "Could not connect to camera stream"}),
        }
        return

    await update_camera_status(camera_id, True)

    try:
        while True:
            if await request.is_disconnected():
                logger.info("SSE client disconnected for camera_id={}", camera_id)
                break

            ret, frame = cap.read()
            if not ret:
                logger.warning("Lost frame from camera_id={}, retrying...", camera_id)
                await asyncio.sleep(1.0)
                cap.release()
                cap = cv2.VideoCapture(rtsp_url)
                continue

            frame_result = await asyncio.get_event_loop().run_in_executor(
                None, run_frame, frame, mappings
            )

            payload = {
                "camera_id": camera_id,
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "detections": [
                    {
                        "label": d.label,
                        "confidence": round(d.confidence, 3),
                        "x1": round(d.x1, 4),
                        "y1": round(d.y1, 4),
                        "x2": round(d.x2, 4),
                        "y2": round(d.y2, 4),
                    }
                    for d in frame_result.detections
                ],
                "slot_hits": [
                    {
                        "slot_id": h.slot_id,
                        "mapping_id": h.mapping_id,
                        "is_occupied": h.is_occupied,
                    }
                    for h in frame_result.slot_hits
                ],
            }

            yield {"data": json.dumps(payload)}
            await asyncio.sleep(_INFERENCE_INTERVAL)

    finally:
        cap.release()
        logger.info("Released RTSP capture for camera_id={}", camera_id)


@router.get(
    "/stream/{camera_id}",
    summary="SSE stream of AI parking detections for a camera",
    description=(
        "Streams Server-Sent Events with YOLO vehicle detections and "
        "slot occupancy hits. Requires the camera to have slot mappings configured."
    ),
)
async def detection_stream_sse(
    camera_id: str,
    request: Request,
    current_user: Any = Depends(get_current_user),
) -> EventSourceResponse:
    return EventSourceResponse(
        _detection_stream(camera_id, request),
        media_type="text/event-stream",
    )
