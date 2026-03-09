from fastapi import status
from app.schemas.response import ResponseCode


class AppException(Exception):
    def __init__(
        self,
        message: str,
        code: ResponseCode = ResponseCode.ERROR,
        status_code: int = status.HTTP_400_BAD_REQUEST,
    ):
        self.message = message
        self.code = code
        self.status_code = status_code
        super().__init__(self.message)
