import asyncio
import cv2
import numpy as np
from typing import AsyncGenerator, List, Dict, Any, Optional
from app.ai.loader import ai_loader
from app.core.logging import logger


class ParkingStreamManager:
    """
    Manages video streams from RTSP URLs or local files.
    Yields JPEG-encoded frames for FastAPI StreamingResponse.
    """

    @staticmethod
    async def stream_raw_video(rtsp_url: str) -> AsyncGenerator[bytes, None]:
        """Reads frames from a video source and yields them unprocessed."""
        cap = cv2.VideoCapture(rtsp_url)
        if not cap.isOpened():
            yield b"--frame\r\nContent-Type: text/plain\r\n\r\nError: stream closed\r\n"
            return

        try:
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break

                success, buffer = cv2.imencode(".jpg", frame)
                if not success:
                    continue

                yield (
                    b"--frame\r\n"
                    b"Content-Type: image/jpeg\r\n\r\n" + buffer.tobytes() + b"\r\n"
                )

                await asyncio.sleep(0.03)  # Roughly 30 fps non-blocking
        finally:
            cap.release()

    @staticmethod
    async def stream_processed_video(
        rtsp_url: str, parking_slots: List[Dict[str, Any]]
    ) -> AsyncGenerator[bytes, None]:
        """Reads, processes with YOLO, and yields annotated frames."""
        cap = cv2.VideoCapture(rtsp_url)
        if not cap.isOpened():
            yield b"--frame\r\nContent-Type: text/plain\r\n\r\nError: stream closed\r\n"
            return

        model = ai_loader.load_model_for_lot(parking_slots)

        try:
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break

                if model:
                    try:
                        results = model(frame)
                        annotated_frame = getattr(results, "plot_im", frame)
                        if isinstance(results, np.ndarray):
                            annotated_frame = results
                        elif hasattr(results, "plot"):
                            annotated_frame = results.plot()
                    except Exception as e:
                        logger.warning(
                            "Frame processing error, falling back to raw frame: {}", e
                        )
                        annotated_frame = frame
                else:
                    annotated_frame = frame
                success, buffer = cv2.imencode(".jpg", annotated_frame)
                if not success:
                    continue

                yield (
                    b"--frame\r\n"
                    b"Content-Type: image/jpeg\r\n\r\n" + buffer.tobytes() + b"\r\n"
                )

                await asyncio.sleep(0.03)
        finally:
            cap.release()
