from pydantic import BaseModel, Field, ConfigDict
from datetime import datetime, timezone
from typing import Optional


class InferenceSettingsInDB(BaseModel):
    settings_id: str = Field(alias="_id", default="inference")
    confidence_threshold: float = 0.25
    iou_threshold: float = 0.45
    frame_skip: int = 1
    stability_buffer: int = 3
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

    model_config = ConfigDict(
        populate_by_name=True,
    )
