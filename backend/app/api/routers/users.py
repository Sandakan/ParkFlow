from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from app.api.deps import get_current_user, get_current_admin
from app.models.user import UserInDB
from app.schemas.user import UserCreate, UserUpdate, UserResponse
from app.schemas.response import APIResponse, ResponseCode
from app.services.user_service import user_service

router = APIRouter()


@router.post(
    "/",
    response_model=APIResponse[dict],
    description="Register a new user in the system with their vehicle details.",
)
async def create_user(
    *,
    user_in: UserCreate,
) -> Any:
    """
    Create new user without logging in. (Registration)
    """
    user = await user_service.create_user(user_in=user_in)
    return APIResponse.success_response(
        message="User created successfully",
        code=ResponseCode.USER_CREATED,
        status_code=201,
        data={"users": [user.model_dump()]},
    )


@router.get(
    "/me",
    response_model=APIResponse[UserResponse],
    description="Retrieve the profile information of the currently authenticated user.",
)
async def read_user_me(
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    """
    Get current user.
    """
    return APIResponse.success_response(
        message="User profile retrieved",
        code=ResponseCode.USER_FETCHED,
        data=UserResponse(**current_user.model_dump()),
    )


@router.put(
    "/{user_id}",
    response_model=APIResponse[UserResponse],
    description="Update user profile details. Users can update their own profile; admins can update any user.",
)
async def update_user(
    *,
    user_id: str,
    user_in: UserUpdate,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    """
    Update a user.
    Users can update their own profile, admins can update any profile.
    """
    if current_user.user_id != user_id and current_user.role != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough permissions to update other users",
        )
    user = await user_service.update_user(user_id=user_id, user_in=user_in)
    return APIResponse.success_response(
        message="User updated successfully", code=ResponseCode.USER_UPDATED, data=user
    )


@router.delete(
    "/{user_id}",
    response_model=APIResponse[dict],
    description="Permanently delete a user from the system. (Admin only)",
)
async def delete_user(
    *,
    user_id: str,
    current_user: UserInDB = Depends(get_current_admin),
) -> Any:
    """
    Delete a user. Only admin can do this.
    """
    from app.repositories.user_repository import user_repository

    success = await user_repository.delete(user_id=user_id)
    if not success:
        return APIResponse.error_response(
            message="User not found", code=ResponseCode.USER_NOT_FOUND, status_code=404
        )
    return APIResponse.success_response(
        message="User deleted successfully", code=ResponseCode.USER_DELETED, data={}
    )
