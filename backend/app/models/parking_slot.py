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
    slot_type: Literal["general", "disabled", "ev"] = "general"
    logical_row: int = 0
    logical_col: int = 0
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )


class CameraSlotMappingInDB(BaseModel):
    mapping_id: str = Field(alias="_id")
    camera_id: str
    slot_id: str  # Foreign key to ParkingSlotInDB
    coordinates: List[Point2D]
    is_occupied: bool = False
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
