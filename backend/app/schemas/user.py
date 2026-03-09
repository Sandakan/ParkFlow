from pydantic import BaseModel, EmailStr, Field
from typing import Optional, Literal
from app.models.user import VehicleDetails, PaymentMethod
from datetime import datetime


class UserBase(BaseModel):
    name: str
    email: EmailStr
    role: Literal["driver", "admin"] = "driver"
    vehicles: list[VehicleDetails] = []
    payment_methods: list[PaymentMethod] = []


class UserCreate(UserBase):
    password: str


class PaymentMethodCreate(BaseModel):
    type: Literal["cash", "card"]
    provider: str
    last4: Optional[str] = None
    is_default: bool = False


class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None
    role: Optional[Literal["driver", "admin"]] = None
    vehicles: Optional[list[VehicleDetails]] = None
    payment_methods: Optional[list[PaymentMethod]] = None


class UserResponse(UserBase):
    user_id: str
    id: str
    created_at: datetime
