from pydantic import BaseModel, Field, ConfigDict
from typing import List, Literal, Optional
from datetime import datetime, timezone


class Point2D(BaseModel):
    x: int
    y: int


class ParkingSlotInDB(BaseModel):
    parking_slot_id: str = Field(alias="_id")
    lot_id: str
    slot_number: str
    status: Literal["vacant", "occupied", "reserved"] = "vacant"
    type_restriction: Literal["car", "tuk-tuk", "bike"] = "car"
    coordinates: List[Point2D]  # multiple points for virtual polygon
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
