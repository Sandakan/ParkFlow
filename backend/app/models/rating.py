from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime, timezone


class RatingInDB(BaseModel):
    rating_id: str = Field(alias="_id")
    user_id: str
    reservation_id: str
    slot_id: str
    lot_id: str
    rating: float = Field(..., ge=1.0, le=5.0)
    comment: Optional[str] = None
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

    model_config = ConfigDict(
        populate_by_name=True,
    )
