from typing import Optional
from pydantic import BaseModel, Field


class CreateParkingLotRequest(BaseModel):
    name: str = Field(..., description="Name of the parking lot")
    address: str = Field(..., description="Physical address of the parking lot")
    latitude: float = Field(..., description="Latitude of the location")
    longitude: float = Field(..., description="Longitude of the location")
    total_slots: int = Field(..., description="Total number of parking slots available", ge=0)


class UpdateParkingLotRequest(BaseModel):
    name: Optional[str] = Field(None, description="Name of the parking lot")
    address: Optional[str] = Field(None, description="Physical address of the parking lot")
    latitude: Optional[float] = Field(None, description="Latitude of the location")
    longitude: Optional[float] = Field(None, description="Longitude of the location")
    total_slots: Optional[int] = Field(None, description="Total number of parking slots available", ge=0)


class CreateCameraRequest(BaseModel):
    lot_id: str = Field(..., description="ID of the parking lot this camera belongs to")
    name: str = Field(..., description="Name/Location of the camera")
    rtsp_url: str = Field(..., description="RTSP URL for the camera feed")


class Point2D(BaseModel):
    x: float
    y: float


class CreateParkingSlotRequest(BaseModel):
    lot_id: str
    slot_number: str
    type_restriction: str = "car"
    coordinates: list[Point2D]
