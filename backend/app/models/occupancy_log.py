from pydantic import BaseModel, Field, ConfigDict
from typing import Literal
from datetime import datetime, timezone


class OccupancyLogInDB(BaseModel):
    occupancy_log_id: str = Field(alias="_id")
    slot_id: str
    event_type: Literal["check-in", "check-out"]
    confidence_score: float
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

    model_config = ConfigDict(
        populate_by_name=True,
    )
