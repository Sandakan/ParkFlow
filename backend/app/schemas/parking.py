from typing import Optional
from pydantic import BaseModel, Field


class CreateParkingLotRequest(BaseModel):
    name: str = Field(..., description="Name of the parking lot")
    address: str = Field(..., description="Physical address of the parking lot")
    latitude: float = Field(..., description="Latitude of the location")
    longitude: float = Field(..., description="Longitude of the location")
    total_slots: int = Field(
        ..., description="Total number of parking slots available", ge=0
    )
    price_per_hour: float = Field(
        default=0.0, description="Price per hour for parking in this lot", ge=0
    )
    slot_width_meters: float = Field(
        default=5.0, description="Average width of a parking slot in meters"
    )
    slot_length_meters: float = Field(
        default=5.0, description="Average length of a parking slot in meters"
    )


class UpdateParkingLotRequest(BaseModel):
    name: Optional[str] = Field(None, description="Name of the parking lot")
    address: Optional[str] = Field(
        None, description="Physical address of the parking lot"
    )
    latitude: Optional[float] = Field(None, description="Latitude of the location")
    longitude: Optional[float] = Field(None, description="Longitude of the location")
    total_slots: Optional[int] = Field(
        None, description="Total number of parking slots available", ge=0
    )
    price_per_hour: Optional[float] = Field(
        None, description="Price per hour for parking in this lot", ge=0
    )
    slot_width_meters: Optional[float] = None
    slot_length_meters: Optional[float] = None


class CreateCameraRequest(BaseModel):
    lot_id: str = Field(..., description="ID of the parking lot this camera belongs to")
    name: str = Field(..., description="Name/Location of the camera")
    rtsp_url: str = Field(..., description="RTSP URL for the camera feed")


class UpdateCameraRequest(BaseModel):
    name: Optional[str] = Field(None, description="Name/Location of the camera")
    rtsp_url: Optional[str] = Field(None, description="RTSP URL for the camera feed")


class Point2D(BaseModel):
    x: float
    y: float


class CreateParkingSlotRequest(BaseModel):
    lot_id: str
    camera_id: str
    slot_number: str
    slot_type: str = "general"
    logical_row: int = 0
    logical_col: int = 0
    coordinates: list[Point2D]


class UpdateParkingSlotRequest(BaseModel):
    slot_number: Optional[str] = None
    slot_type: Optional[str] = None
    logical_row: Optional[int] = None
    logical_col: Optional[int] = None
    coordinates: Optional[list[Point2D]] = None
