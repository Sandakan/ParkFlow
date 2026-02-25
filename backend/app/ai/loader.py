import os
import json
import uuid
from typing import List, Dict, Any, Optional
from shapely.geometry import Polygon
from ultralytics.solutions import ParkingManagement
from app.core.config import settings


class ParkingAILoader:
    """
    Dynamically loads parking slots from the DB, saves them to a temp JSON file
    required by the Ultralytics ParkingManagement module, initializes the model,
    and deletes the temp file.
    """

    def __init__(self):
        self.tmp_dir = os.path.join(os.getcwd(), "tmp")
        os.makedirs(self.tmp_dir, exist_ok=True)

    def _generate_bounding_box_json(self, parking_slots: List[Dict[str, Any]]) -> str:
        """
        Converts MongoDB ParkingSlot models into the JSON format required by Ultralytics.
        The Ultralytics format is a list of dicts, each containing 'points' as a list of [x, y].
        """
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
        self, parking_slots: List[Dict[str, Any]]
    ) -> Optional[ParkingManagement]:
        """
        Initializes the Ultralytics ParkingManagement object dynamically.
        Expects a list of dictionaries representing the parking slots in the DB.
        """
        if not parking_slots:
            return None

        # 1. Generate temp JSON file with polygons
        json_file_path = self._generate_bounding_box_json(parking_slots)

        # 2. Initialize the YOLO model
        try:
            model = ParkingManagement(
                model=settings.YOLO_MODEL_PATH,
                json_file=json_file_path,
                conf=settings.YOLO_CONFIDENCE,
            )
            return model
        finally:
            # 3. Clean up the temp JSON file
            if os.path.exists(json_file_path):
                os.remove(json_file_path)


# Instantiate a global factory/loader instance
ai_loader = ParkingAILoader()
