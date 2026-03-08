from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from app.models.user import VehicleDetails
from typing import Literal


class CreateReservationRequest(BaseModel):
    slot_id: str
    lot_id: Optional[str] = None
    vehicle: VehicleDetails
    start_time: datetime
    duration_minutes: int
    payment_method: Literal["cash", "card"]


class ReservationResponse(BaseModel):
    id: str
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime
    vehicle: VehicleDetails
    duration_minutes: int
    payment_method: str
    total_price: float
    base_rate: float
    check_in_time: Optional[datetime] = None
    check_out_time: Optional[datetime] = None
    actual_end_time: datetime
    total_billed_price: float
    status: str
    qr_code_token: str
    lot_name: str
    slot_name: str
    created_at: datetime
    updated_at: datetime
