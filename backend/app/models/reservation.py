from pydantic import BaseModel, Field, ConfigDict
from typing import Literal, Optional
from datetime import datetime


class ReservationInDB(BaseModel):
    reservation_id: str = Field(alias="_id")
    user_id: str
    slot_id: str
    start_time: datetime
    end_time: datetime
    status: Literal["active", "completed", "cancelled"] = "active"
    qr_code_token: str
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    updated_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    deleted_at: Optional[datetime] = None

    model_config = ConfigDict(
        populate_by_name=True,
    )
