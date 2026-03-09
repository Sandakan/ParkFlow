from pydantic import BaseModel, Field, ConfigDict
from typing import Literal, Optional
from datetime import datetime, timezone
from .user import VehicleDetails


class ReservationInDB(BaseModel):
    reservation_id: str = Field(alias="_id")
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime
    vehicle: VehicleDetails
    duration_minutes: int
    payment_method: Literal["cash", "card"]
    total_price: float
    base_rate: float
    check_in_time: Optional[datetime] = None
    check_out_time: Optional[datetime] = None
    actual_end_time: datetime  # Final time for billing. Charged even if the user didn't show up.
    total_billed_price: float
    status: Literal["active", "completed", "cancelled"] = "active"
    qr_code_token: str
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
