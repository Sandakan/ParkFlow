from pydantic import BaseModel, EmailStr, Field
from typing import Optional, Literal
from app.models.user import VehicleDetails
from datetime import datetime


class UserBase(BaseModel):
    name: str
    email: EmailStr
    role: Literal["driver", "admin"] = "driver"
    vehicle_details: Optional[VehicleDetails] = None


class UserCreate(UserBase):
    password: str


class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None
    role: Optional[Literal["driver", "admin"]] = None
    vehicle_details: Optional[VehicleDetails] = None


class UserResponse(UserBase):
    user_id: str
    id: str
    created_at: datetime

