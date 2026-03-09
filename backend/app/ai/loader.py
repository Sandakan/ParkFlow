import os
import json
import uuid
from typing import List, Dict, Any, Optional
from shapely.geometry import Polygon
from ultralytics.solutions import ParkingManagement
from app.core.config import settings


class ParkingAILoader:
    def __init__(self):
        self.tmp_dir = os.path.join(os.getcwd(), "tmp")
        os.makedirs(self.tmp_dir, exist_ok=True)

    def _generate_bounding_box_json(self, parking_slots: List[Dict[str, Any]]) -> str:
        annotated_slots = []
        for slot in parking_slots:
            points = [[pt["x"], pt["y"]] for pt in slot.get("coordinates", [])]
            if len(points) >= 3:
                annotated_slots.append({"points": points})

        tmp_filename = os.path.join(
            self.tmp_dir, f"bounding_boxes_{uuid.uuid4().hex}.json"
        )
        with open(tmp_filename, "w") as f:
            json.dump(annotated_slots, f)

        return tmp_filename

    def load_model_for_lot(
        self,
        parking_slots: List[Dict[str, Any]],
        inference_settings: Optional[Any] = None,
    ) -> Optional[ParkingManagement]:
        if not parking_slots:
            return None

        json_file_path = self._generate_bounding_box_json(parking_slots)

        # Build config
        conf = (
            inference_settings.confidence_threshold
            if inference_settings
            else settings.YOLO_CONFIDENCE
        )

        try:
            model = ParkingManagement(
                model=settings.YOLO_MODEL_PATH,
                json_file=json_file_path,
                conf=conf,
            )
            return model
        finally:
            if os.path.exists(json_file_path):
                os.remove(json_file_path)


ai_loader = ParkingAILoader()
