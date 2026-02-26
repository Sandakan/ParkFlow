from datetime import timedelta
from typing import Any
from fastapi import APIRouter, Body, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from jose import jwt, JWTError

from app.core.config import settings
from app.core.security import create_access_token, create_refresh_token
from app.schemas.token import Token, TokenPayload
from app.schemas.response import APIResponse, ResponseCode
from app.models.user import UserInDB
from app.services.user_service import user_service
from app.api.deps import get_current_user

router = APIRouter()


@router.post(
    "/login",
    response_model=APIResponse[Token],
    description="Authenticate user with email and password to receive access and refresh tokens.",
)
async def login_access_token(form_data: OAuth2PasswordRequestForm = Depends()) -> Any:
    """
    OAuth2 compatible token login, get an access token for future requests
    """
    user = await user_service.authenticate(
        email=form_data.username, password=form_data.password
    )
    if not user:
        return APIResponse.error_response(
            message="Incorrect email or password",
            code=ResponseCode.INVALID_CREDENTIALS,
            status_code=status.HTTP_400_BAD_REQUEST,
        )
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    refresh_token_expires = timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)

    token_data = Token(
        access_token=create_access_token(
            user.user_id, expires_delta=access_token_expires
        ),
        refresh_token=create_refresh_token(
            user.user_id, expires_delta=refresh_token_expires
        ),
        token_type="bearer",
        access_token_expires_at=int(access_token_expires.total_seconds() * 1000),
        refresh_token_expires_at=int(refresh_token_expires.total_seconds() * 1000),
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

    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    refresh_token_expires = timedelta(minutes=settings.REFRESH_TOKEN_EXPIRE_MINUTES)

    new_token = Token(
        access_token=create_access_token(
            user.user_id, expires_delta=access_token_expires
        ),
        refresh_token=create_refresh_token(
            user.user_id, expires_delta=refresh_token_expires
        ),
        token_type="bearer",
        access_token_expires_at=int(access_token_expires.total_seconds() * 1000),
        refresh_token_expires_at=int(refresh_token_expires.total_seconds() * 1000),
    )

    return APIResponse.success_response(
        message="Token refreshed successfully",
        code=ResponseCode.TOKEN_REFRESHED,
        data=new_token,
    )


@router.post(
    "/test-token",
    response_model=APIResponse[UserInDB],
    description="Validate the current access token and return the associated user profile.",
)
async def test_token(current_user: UserInDB = Depends(get_current_user)) -> Any:
    """
    Test access token
    """
    return APIResponse.success_response(
        message="Token is valid", code=ResponseCode.SUCCESS, data=current_user
    )
