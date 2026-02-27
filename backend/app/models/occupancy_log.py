from pydantic import BaseModel, Field, ConfigDict
from typing import Literal, Optional
from datetime import datetime, timezone


class OccupancyLogInDB(BaseModel):
    occupancy_log_id: str = Field(alias="_id")
    slot_id: str
    event_type: Literal["check-in", "check-out"]
    confidence_score: float
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
