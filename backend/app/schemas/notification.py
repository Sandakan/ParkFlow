from pydantic import BaseModel, Field
from typing import Optional, Any, Literal
from datetime import datetime

class NotificationBase(BaseModel):
    title: str
    message: str
    type: Literal["info", "success", "warning", "error"] = "info"
    payload: Optional[dict[str, Any]] = {}

class NotificationCreate(NotificationBase):
    user_id: Optional[str] = None

class NotificationResponse(NotificationBase):
    id: str = Field(alias="_id")
    user_id: Optional[str] = None
    created_at: datetime
    read_at: Optional[datetime] = None

    class Config:
        populate_by_name = True
