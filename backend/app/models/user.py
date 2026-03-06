from pydantic import BaseModel, EmailStr, Field, ConfigDict
from typing import Optional, Literal
from datetime import datetime, timezone
import uuid


class VehicleDetails(BaseModel):
    plate_number: str
    type: Literal["car", "three-wheeler", "bike"]


class PaymentMethod(BaseModel):
    id: str = Field(default_factory=lambda: str(uuid.uuid4()))
    type: Literal["cash", "card"]
    provider: str
    last4: Optional[str] = None
    is_default: bool = False


class UserInDB(BaseModel):
    user_id: str = Field(alias="_id")
    name: str
    email: EmailStr
    password_hash: str
    role: Literal["driver", "admin"] = "driver"
    vehicles: list[VehicleDetails] = Field(default_factory=list)
    payment_methods: list[PaymentMethod] = Field(default_factory=list)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
