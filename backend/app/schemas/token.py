from pydantic import BaseModel
from typing import Optional


class Token(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    access_token_expires_at: int
    refresh_token_expires_at: int


class TokenPayload(BaseModel):
    sub: Optional[str] = None
    exp: Optional[int] = None
