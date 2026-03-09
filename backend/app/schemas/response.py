from enum import Enum
from typing import Generic, TypeVar, Optional, Any
from pydantic import BaseModel, ConfigDict

T = TypeVar("T")


class ResponseCode(str, Enum):
    # General
    SUCCESS = "SUCCESS"
    ERROR = "ERROR"
    VALIDATION_ERROR = "VALIDATION_ERROR"
    UNAUTHORIZED = "UNAUTHORIZED"
    FORBIDDEN = "FORBIDDEN"
    NOT_FOUND = "NOT_FOUND"
    INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"

    # User
    USER_CREATED = "USER_CREATED"
    USER_FETCHED = "USER_FETCHED"
    USER_UPDATED = "USER_UPDATED"
    USER_DELETED = "USER_DELETED"
    USER_ALREADY_EXISTS = "USER_ALREADY_EXISTS"
    USER_NOT_FOUND = "USER_NOT_FOUND"
    INVALID_CREDENTIALS = "INVALID_CREDENTIALS"

    # Token
    LOGIN_SUCCESS = "LOGIN_SUCCESS"
    TOKEN_REFRESHED = "TOKEN_REFRESHED"
    INVALID_TOKEN = "INVALID_TOKEN"
    TOKEN_EXPIRED = "TOKEN_EXPIRED"

    SETTINGS_FETCHED = "SETTINGS_FETCHED"
    SETTINGS_UPDATED = "SETTINGS_UPDATED"

    VEHICLE_ALREADY_EXISTS = "VEHICLE_ALREADY_EXISTS"
    VEHICLE_NOT_FOUND = "VEHICLE_NOT_FOUND"

    PAYMENT_METHOD_NOT_FOUND = "PAYMENT_METHOD_NOT_FOUND"

    RESERVATION_LOT_ID_REQUIRED = "RESERVATION_LOT_ID_REQUIRED"
    RESERVATION_NO_AVAILABLE_SLOTS = "RESERVATION_NO_AVAILABLE_SLOTS"
    RESERVATION_SLOT_NOT_FOUND = "RESERVATION_SLOT_NOT_FOUND"
    RESERVATION_SLOT_OCCUPIED = "RESERVATION_SLOT_OCCUPIED"
    RESERVATION_LOT_NOT_FOUND = "RESERVATION_LOT_NOT_FOUND"
    RESERVATION_CREATED = "RESERVATION_CREATED"
    RESERVATION_SLOT_TIME_CONFLICT = "RESERVATION_SLOT_TIME_CONFLICT"
    RESERVATION_PAST_TIME = "RESERVATION_PAST_TIME"

    CAMERA_NOT_FOUND = "CAMERA_NOT_FOUND"
    CAMERA_RTSP_NOT_CONFIGURED = "CAMERA_RTSP_NOT_CONFIGURED"
    CAMERA_WEBRTC_FAILED = "CAMERA_WEBRTC_FAILED"
    CAMERA_NO_UPDATE_DATA = "CAMERA_NO_UPDATE_DATA"

    PARKING_LOT_NOT_FOUND = "PARKING_LOT_NOT_FOUND"
    PARKING_SLOT_NOT_FOUND = "PARKING_SLOT_NOT_FOUND"

    PERMISSION_DENIED = "PERMISSION_DENIED"
    BAD_REQUEST = "BAD_REQUEST"

    # Forgot Password
    OTP_SENT = "OTP_SENT"
    OTP_VERIFIED = "OTP_VERIFIED"
    PASSWORD_RESET_SUCCESS = "PASSWORD_RESET_SUCCESS"
    INVALID_OTP = "INVALID_OTP"


class APIResponse(BaseModel, Generic[T]):
    success: bool
    message: str
    code: ResponseCode
    status_code: int
    data: Optional[T] = None

    model_config = ConfigDict(arbitrary_types_allowed=True)

    @classmethod
    def success_response(
        cls,
        message: str = "Success",
        data: Optional[T] = None,
        code: ResponseCode = ResponseCode.SUCCESS,
        status_code: int = 200,
    ) -> "APIResponse[T]":
        return cls(
            success=True, message=message, code=code, status_code=status_code, data=data
        )

    @classmethod
    def error_response(
        cls,
        message: str = "An error occurred",
        code: ResponseCode = ResponseCode.ERROR,
        status_code: int = 400,
    ) -> "APIResponse[Any]":
        return cls(
            success=False,
            message=message,
            code=code,
            status_code=status_code,
            data=None,
        )
