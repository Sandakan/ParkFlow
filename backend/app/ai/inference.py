import cv2
import numpy as np
from typing import List, Dict, Any, Tuple
from app.ai.loader import ai_loader
from app.core.logging import logger


def process_parking_image(
    image_bytes: bytes, parking_slots: List[Dict[str, Any]]
) -> Tuple[Dict[str, Any], np.ndarray]:
    """
    Processes a single image frame to detect parking occupancy.

    Args:
        image_bytes: The raw image bytes uploaded by the user.
        parking_slots: The list of parking slots from the database for this camera/lot.

    Returns:
        A tuple of (occupancy_data_dict, annotated_image_array)
    """
    # 1. Convert image bytes to numpy array compatible with OpenCV/YOLO
    nparr = np.frombuffer(image_bytes, np.uint8)
    im0 = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    if im0 is None:
        raise ValueError("Could not decode image")

    # 2. Load the model dynamically with the given slots
    model = ai_loader.load_model_for_lot(parking_slots)

    if not model:
        # If no slots, just return empty data and the raw image
        return {"total_slots": 0, "occupied_slots": 0, "available_slots": 0}, im0

    # 3. Run inference
    # ParkingManagement() is callable in the Ultralytics pipeline.
    # It returns a modified dictionary or object. We'll extract details and the plotted image.
    try:
        # Note: the ultralytics solution alters the class state and returns the processed frame
        results = model(im0)

        # The exact properties of `results` or the `model` object after call:
        # solutions.ParkingManagement usually modifies the frame in-place or returns it.
        # It also keeps track of parking spots.
        # Let's inspect the model attributes based on standard solutions.

        # Usually, the annotated frame is attached as model.im0 or returned directly
        annotated_frame = getattr(model, "im0", im0)
        if hasattr(results, "plot_im"):
            annotated_frame = results.plot_im
        elif isinstance(results, np.ndarray):
            annotated_frame = results

        # Occupancy statistics are typically stored in the model class properties
        # For ultralytics ParkingPtsSelection/Management, it tracks:
        # model.parking_zones, model.occupancy, model.empty_spots, etc.

        total_slots = getattr(model, "total_spots", len(parking_slots))
        occupied_slots = getattr(model, "occupied_spots", 0)

        # Fallback if internal vars differ slightly
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
