from pydantic import BaseModel, EmailStr, Field, ConfigDict
from typing import Optional, Literal
from datetime import datetime, timezone


class VehicleDetails(BaseModel):
    plate_number: str
    type: Literal["car", "three-wheeler", "bike"]


class UserInDB(BaseModel):
    user_id: str = Field(alias="_id")
    name: str
    email: EmailStr
    password_hash: str
    role: Literal["driver", "admin"] = "driver"
    vehicle_details: Optional[VehicleDetails] = None
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

    model_config = ConfigDict(
        populate_by_name=True,
    )
