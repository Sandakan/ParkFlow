from enum import Enum
from typing import Generic, TypeVar, Optional, Any
from pydantic import BaseModel, ConfigDict
from fastapi.responses import JSONResponse

T = TypeVar("T")


class ResponseCode(str, Enum):
    # General Codes
    SUCCESS = "SUCCESS"
    ERROR = "ERROR"
    VALIDATION_ERROR = "VALIDATION_ERROR"
    UNAUTHORIZED = "UNAUTHORIZED"
    FORBIDDEN = "FORBIDDEN"
    NOT_FOUND = "NOT_FOUND"
    INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"

    # User specific
    USER_CREATED = "USER_CREATED"
    USER_FETCHED = "USER_FETCHED"
    USER_UPDATED = "USER_UPDATED"
    USER_DELETED = "USER_DELETED"
    USER_ALREADY_EXISTS = "USER_ALREADY_EXISTS"
    USER_NOT_FOUND = "USER_NOT_FOUND"
    INVALID_CREDENTIALS = "INVALID_CREDENTIALS"

    # Token specific
    LOGIN_SUCCESS = "LOGIN_SUCCESS"
    TOKEN_REFRESHED = "TOKEN_REFRESHED"
    INVALID_TOKEN = "INVALID_TOKEN"
    TOKEN_EXPIRED = "TOKEN_EXPIRED"


class APIResponse(BaseModel, Generic[T]):
    success: bool
    message: str
    code: ResponseCode
    status_code: int
    data: Optional[T] = None

    model_config = ConfigDict(arbitrary_types_allowed=True)

    def to_json_response(self) -> JSONResponse:
        return JSONResponse(status_code=self.status_code, content=self.model_dump())

    @classmethod
    def success_response(
        cls,
        message: str = "Success",
        data: Optional[Any] = None,
        code: ResponseCode = ResponseCode.SUCCESS,
        status_code: int = 200,
    ) -> JSONResponse:
        return cls(
            success=True, message=message, code=code, status_code=status_code, data=data
        ).to_json_response()

    @classmethod
    def error_response(
        cls,
        message: str = "An error occurred",
        code: ResponseCode = ResponseCode.ERROR,
        status_code: int = 400,
    ) -> JSONResponse:
        return cls(
            success=False,
            message=message,
            code=code,
            status_code=status_code,
            data=None,
        ).to_json_response()
