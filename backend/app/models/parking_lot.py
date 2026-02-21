from pydantic import BaseModel, Field, ConfigDict
from typing import Tuple, Literal


class Point(BaseModel):
    type: Literal["Point"] = "Point"
    coordinates: Tuple[float, float]  # [longitude, latitude]


class ParkingLotInDB(BaseModel):
    parking_lot_id: str = Field(alias="_id")
    name: str
    location: Point
    total_slots: int
    rtsp_url: str

    model_config = ConfigDict(
        populate_by_name=True,
    )
