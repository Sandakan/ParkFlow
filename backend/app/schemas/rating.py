from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class RatingCreate(BaseModel):
    rating: float = Field(..., ge=1.0, le=5.0)
    comment: Optional[str] = None


class RatingResponse(BaseModel):
    id: str
    user_id: str
    reservation_id: str
    slot_id: str
    lot_id: str
    rating: float
    comment: Optional[str]
    created_at: datetime
