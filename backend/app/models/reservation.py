from pydantic import BaseModel, Field, ConfigDict
from typing import Literal
from datetime import datetime


class ReservationInDB(BaseModel):
    reservation_id: str = Field(alias="_id")
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime
    status: Literal["active", "completed", "cancelled"] = "active"
    qr_code_token: str

    model_config = ConfigDict(
        populate_by_name=True,
    )
