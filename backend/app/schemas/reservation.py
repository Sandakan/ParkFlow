from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime


class CreateReservationRequest(BaseModel):
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime


class ReservationResponse(BaseModel):
    id: str
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime
    status: str
    created_at: datetime
    updated_at: datetime
