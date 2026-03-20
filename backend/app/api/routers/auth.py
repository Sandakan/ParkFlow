from datetime import datetime, timedelta, timezone
from typing import Any
from fastapi import APIRouter, Body, Depends, HTTPException, status, Form
from jose import jwt, JWTError
from app.api.deps import get_current_user

from app.core.config import settings
from app.core.security import create_access_token, create_refresh_token
from app.schemas.token import Token, TokenPayload, LoginRequest
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.user import UserResponse
from app.models.user import UserInDB
from app.services.user_service import user_service
from app.schemas.auth import (
    ForgotPasswordRequest,
    VerifyOTPRequest,
    ResetPasswordRequest,
)
from app.services.email_service import email_service
from app.core.redis import redis_cache
from loguru import logger
import secrets

router = APIRouter()


@router.post(
    "/login",
    response_model=APIResponse[Token],
    description="Authenticate user with email and password to receive access and refresh tokens.",
)
async def login_access_token(
    email: str = Form(...),
    password: str = Form(...),
) -> Any:
    """
    Login with email and password, get an access token for future requests
    """
    user = await user_service.authenticate(email=email, password=password)
    if not user:
        return APIResponse.error_response(
            message="Incorrect email or password",
            code=ResponseCode.INVALID_CREDENTIALS,
            status_code=status.HTTP_400_BAD_REQUEST,
        )
    access_token_expires = datetime.now(timezone.utc) + timedelta(
        minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
    )
    refresh_token_expires = datetime.now(timezone.utc) + timedelta(
        minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES
    )

    token_data = Token(
        access_token=create_access_token(
            user.user_id,
            expires_delta=timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES),
        ),
        refresh_token=create_refresh_token(
            user.user_id,
            expires_delta=timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES),
        ),
        token_type="bearer",
        access_token_expires_at=access_token_expires.isoformat(),
        refresh_token_expires_at=refresh_token_expires.isoformat(),
    )

    return APIResponse.success_response(
        message="Login successful", code=ResponseCode.LOGIN_SUCCESS, data=token_data
    )


@router.post(
    "/refresh",
    response_model=APIResponse[Token],
    description="Exchange a valid refresh token for a new set of access and refresh tokens.",
)
async def refresh_token(refresh_token: str = Body(..., embed=True)) -> Any:
    """
    Refresh access token
    """
    try:
        payload = jwt.decode(
            refresh_token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (JWTError, ValueError):
        return APIResponse.error_response(
            message="Could not validate credentials",
            code=ResponseCode.INVALID_TOKEN,
            status_code=status.HTTP_403_FORBIDDEN,
        )

    user = await user_service.get_user(user_id=token_data.sub)
    if not user:
        return APIResponse.error_response(
            message="User not found", code=ResponseCode.USER_NOT_FOUND, status_code=404
        )

    access_token_expires = datetime.now(timezone.utc) + timedelta(
        minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
    )
    refresh_token_expires = datetime.now(timezone.utc) + timedelta(
        minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES
    )

    new_token = Token(
        access_token=create_access_token(
            user.user_id,
            expires_delta=timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES),
        ),
        refresh_token=create_refresh_token(
            user.user_id,
            expires_delta=timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES),
        ),
        token_type="bearer",
        access_token_expires_at=access_token_expires.isoformat(),
        refresh_token_expires_at=refresh_token_expires.isoformat(),
    )

    return APIResponse.success_response(
        message="Token refreshed successfully",
        code=ResponseCode.TOKEN_REFRESHED,
        data=new_token,
    )


@router.post(
    "/test-token",
    response_model=APIResponse[UserResponse],
    description="Validate the current access token and return the associated user profile.",
)
async def test_token(current_user: UserInDB = Depends(get_current_user)) -> Any:
    """
    Test access token
    """
    return APIResponse.success_response(
        message="Token is valid",
        code=ResponseCode.SUCCESS,
        data=UserResponse(**current_user.model_dump(), id=current_user.user_id),
    )


@router.post(
    "/forgot-password",
    response_model=APIResponse[None],
    description="Generate and send an OTP to the user's email for password reset.",
)
async def forgot_password(
    request: ForgotPasswordRequest,
) -> Any:
    logger.info(f"Forgot password requested for email: {request.email}")
    user = await user_service.get_user_by_email(request.email)
    if not user:
        logger.warning(f"Forgot password requested for non-existent email: {request.email}")
        return APIResponse.error_response(
            message="User with this email not found.",
            code=ResponseCode.USER_NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND,
        )

    logger.info(f"User found for email reset: {user.email}")
    otp = "".join([str(secrets.randbelow(10)) for _ in range(6)])

    # Store OTP in Redis for 5 minutes
    await redis_cache.client.setex(f"otp:{request.email}", 300, otp)
    logger.info(f"OTP generated and stored in Redis for {request.email}")

    await email_service.send_templated_email(
        subject="ParkFlow Password Reset OTP",
        recipients=[request.email],
        title="Password Reset",
        content=f"""
        <p>Your OTP code is: <b style="font-size: 24px; color: #0f172a; letter-spacing: 2px;">{otp}</b></p>
        <p>This code will expire in 5 minutes. If you did not request this, please ignore this email.</p>
        """,
    )

    return APIResponse.success_response(
        message="OTP sent successfully",
        code=ResponseCode.OTP_SENT,
    )


@router.post(
    "/verify-otp",
    response_model=APIResponse[None],
    description="Verify the OTP sent to the user's email.",
)
async def verify_otp(
    request: VerifyOTPRequest,
) -> Any:
    stored_otp = await redis_cache.client.get(f"otp:{request.email}")
    if not stored_otp or stored_otp.decode() != request.otp:
        return APIResponse.error_response(
            message="Invalid or expired OTP",
            code=ResponseCode.INVALID_OTP,
            status_code=400,
        )

    return APIResponse.success_response(
        message="OTP verified successfully",
        code=ResponseCode.OTP_VERIFIED,
    )


@router.post(
    "/reset-password",
    response_model=APIResponse[None],
    description="Reset the user's password using a verified OTP.",
)
async def reset_password(
    request: ResetPasswordRequest,
) -> Any:
    stored_otp = await redis_cache.client.get(f"otp:{request.email}")
    if not stored_otp or stored_otp.decode() != request.otp:
        return APIResponse.error_response(
            message="Invalid or expired OTP",
            code=ResponseCode.INVALID_OTP,
            status_code=400,
        )

    user = await user_service.get_user_by_email(request.email)
    if not user:
        return APIResponse.error_response(
            message="User not found", code=ResponseCode.USER_NOT_FOUND, status_code=404
        )

    await user_service.reset_password(user.user_id, request.password)

    await redis_cache.client.delete(f"otp:{request.email}")

    return APIResponse.success_response(
        message="Password reset successfully",
        code=ResponseCode.PASSWORD_RESET_SUCCESS,
    )
