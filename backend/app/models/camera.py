from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime, timezone


class CameraInDB(BaseModel):
    camera_id: str = Field(alias="_id")
    lot_id: str
    name: str
    rtsp_url: str
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
