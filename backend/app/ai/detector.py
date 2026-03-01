from dataclasses import dataclass, field
from typing import List, Dict, Any

import numpy as np
from shapely.geometry import box as shapely_box, Polygon
from ultralytics import YOLO

from app.core.config import settings
from app.core.logging import logger


@dataclass
class DetectedBox:
    label: str
    confidence: float
    x1: float  # normalized 0–1
    y1: float
    x2: float
    y2: float


@dataclass
class SlotHit:
    slot_id: str
    mapping_id: str
    is_occupied: bool


@dataclass
class FrameResult:
    detections: List[DetectedBox] = field(default_factory=list)
    slot_hits: List[SlotHit] = field(default_factory=list)


_model: YOLO | None = None


def _get_model() -> YOLO:
    global _model
    if _model is None:
        logger.info("Loading YOLO model from {}", settings.YOLO_MODEL_PATH)
        _model = YOLO(settings.YOLO_MODEL_PATH)
        logger.info("YOLO model loaded successfully")
    return _model


def run_frame(frame: np.ndarray, mappings: List[Dict[str, Any]]) -> FrameResult:
    """
    Runs YOLO inference on `frame` and checks which camera slot mappings
    are overlapped by a detected vehicle.

    Args:
        frame: BGR numpy array from cv2.
        mappings: List of camera_slot_mapping documents from MongoDB.
                  Each mapping must have 'coordinates' (list of {x, y} dicts,
                  normalized 0–1) and '_id' / 'slot_id' fields.

    Returns:
        FrameResult with detections and slot_hits.
    """
    model = _get_model()

    result = FrameResult()

    try:
        predictions = model.predict(frame, conf=settings.YOLO_CONFIDENCE, verbose=False)
    except Exception:
        logger.exception("YOLO prediction failed")
        return result

    if not predictions or predictions[0].boxes is None:
        return result

    boxes = predictions[0].boxes
    if boxes.xywhn is None or len(boxes) == 0:
        return result

    # Build DetectedBox list from normalized xyxy
    xyxyn = boxes.xyxyn.cpu().numpy()  # shape (N, 4)
    confs = boxes.conf.cpu().numpy()
    cls_ids = boxes.cls.cpu().numpy().astype(int)
    names = model.names  # {id: label}

    detected_boxes: List[DetectedBox] = []
    for i in range(len(xyxyn)):
        x1, y1, x2, y2 = xyxyn[i]
        detected_boxes.append(
            DetectedBox(
                label=names.get(cls_ids[i], str(cls_ids[i])),
                confidence=float(confs[i]),
                x1=float(x1),
                y1=float(y1),
                x2=float(x2),
                y2=float(y2),
            )
        )

    result.detections = detected_boxes

    # For each mapping, build its Shapely polygon and check overlap
    for mapping in mappings:
        coords = mapping.get("coordinates", [])
        if len(coords) < 3:
            continue

        try:
            slot_poly = Polygon([(pt["x"], pt["y"]) for pt in coords])
            if not slot_poly.is_valid:
                slot_poly = slot_poly.buffer(0)
        except Exception:
            logger.warning("Invalid polygon for mapping {}", mapping.get("_id"))
            continue

        is_occupied = False
        for det_box in detected_boxes:
            vehicle_shape = shapely_box(det_box.x1, det_box.y1, det_box.x2, det_box.y2)
            centroid = vehicle_shape.centroid

            if slot_poly.contains(centroid):
                label = det_box.label.lower()

                if label == "space-empty":
                    continue

                if label in [
                    "space-occupied",
                    "car",
                    "bus",
                    "truck",
                    "motorcycle",
                    "van",
                ]:
                    is_occupied = True
                    break

                if label != "spaces":
                    is_occupied = True
                    break

        mapping_id = str(mapping.get("_id", ""))
        slot_id = str(mapping.get("slot_id", ""))
        result.slot_hits.append(
            SlotHit(
                slot_id=slot_id,
                mapping_id=mapping_id,
                is_occupied=is_occupied,
            )
        )

    logger.debug(
        "Frame processed: {} detections, {} slot hits",
        len(result.detections),
        sum(1 for h in result.slot_hits if h.is_occupied),
    )
    return result
