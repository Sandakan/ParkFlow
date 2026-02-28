from fastapi import status
from app.schemas.response import ResponseCode

class AppException(Exception):
    """
    Custom exception class for ParkFlow application that allows
    sending standard ResponseCodes back to the client.
    """
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
