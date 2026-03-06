from pydantic import BaseModel, Field, ConfigDict
from typing import Tuple, Literal, Optional
from datetime import datetime, timezone


class Point(BaseModel):
    type: Literal["Point"] = "Point"
    coordinates: Tuple[float, float]  # [longitude, latitude]


class ParkingLotInDB(BaseModel):
    parking_lot_id: str = Field(alias="_id")
    name: str
    location: Point
    total_slots: int
    slot_width_meters: float = 5.0
    slot_length_meters: float = 5.0
    average_rating: float = 0.0
    rating_count: int = 0
    total_rating_sum: float = 0.0
    price_per_hour: float = 20.0
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
