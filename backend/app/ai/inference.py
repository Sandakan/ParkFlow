import cv2
import numpy as np
from typing import List, Dict, Any, Tuple, Optional
from app.ai.loader import ai_loader
from app.core.logging import logger


def process_parking_image(
    image_bytes: bytes,
    parking_slots: List[Dict[str, Any]],
    inference_settings: Optional[Any] = None,
) -> Tuple[Dict[str, Any], np.ndarray]:
    """
    Processes a single image frame to detect parking occupancy.

    Args:
        image_bytes: The raw image bytes uploaded by the user.
        parking_slots: The list of parking slots from the database for this camera/lot.
        inference_settings: Optional AI inference settings.

    Returns:
        A tuple of (occupancy_data_dict, annotated_image_array)
    """
    # 1. Convert image bytes to numpy array compatible with OpenCV/YOLO
    nparr = np.frombuffer(image_bytes, np.uint8)
    im0 = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    if im0 is None:
        raise ValueError("Could not decode image")

    # 2. Load the model dynamically with the given slots
    model = ai_loader.load_model_for_lot(
        parking_slots, inference_settings=inference_settings
    )

    if not model:
        return {"total_slots": 0, "occupied_slots": 0, "available_slots": 0}, im0

    # 3. Run inference
    try:
        results = model(im0)

        annotated_frame = getattr(model, "im0", im0)
        if hasattr(results, "plot_im"):
            annotated_frame = results.plot_im
        elif isinstance(results, np.ndarray):
            annotated_frame = results

        total_slots = getattr(model, "total_spots", len(parking_slots))
        occupied_slots = getattr(model, "occupied_spots", 0)

        if not hasattr(model, "occupied_spots") and hasattr(model, "occupancy_count"):
            occupied_slots = model.occupancy_count

        available_slots = getattr(model, "empty_spots", total_slots - occupied_slots)

        occupancy_data = {
            "total_slots": total_slots,
            "occupied_slots": occupied_slots,
            "available_slots": available_slots,
        }

        return occupancy_data, annotated_frame

    except Exception as e:
        logger.exception("Inference error on frame")
        return {"error": str(e)}, im0
