from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from app.api.deps import get_current_user, get_current_admin
from app.models.user import UserInDB, VehicleDetails, PaymentMethod
from app.schemas.user import UserCreate, UserUpdate, UserResponse, PaymentMethodCreate
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
        data={
            "users": [UserResponse(**user.model_dump(), id=user.user_id).model_dump()]
        },
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
    user_data = current_user.model_dump()
    return APIResponse.success_response(
        message="User profile retrieved",
        code=ResponseCode.USER_FETCHED,
        data=UserResponse(**user_data, id=current_user.user_id),
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
        message="User updated successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
    )


@router.post(
    "/me/vehicles",
    response_model=APIResponse[UserResponse],
    description="Add a new vehicle to the user's profile.",
)
async def add_vehicle(
    *,
    vehicle_in: VehicleDetails,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    if any(v.plate_number == vehicle_in.plate_number for v in current_user.vehicles):
        raise HTTPException(
            status_code=400,
            detail="Vehicle with this license plate already exists",
        )

    current_user.vehicles.append(vehicle_in)
    user = await user_service.update_user(
        user_id=current_user.user_id, user_in=UserUpdate(vehicles=current_user.vehicles)
    )
    return APIResponse.success_response(
        message="Vehicle added successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
    )


@router.delete(
    "/me/vehicles/{plate_number}",
    response_model=APIResponse[UserResponse],
    description="Remove a vehicle from the user's profile.",
)
async def remove_vehicle(
    *,
    plate_number: str,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    new_vehicles = [v for v in current_user.vehicles if v.plate_number != plate_number]
    if len(new_vehicles) == len(current_user.vehicles):
        raise HTTPException(
            status_code=404,
            detail="Vehicle not found",
        )

    user = await user_service.update_user(
        user_id=current_user.user_id, user_in=UserUpdate(vehicles=new_vehicles)
    )
    return APIResponse.success_response(
        message="Vehicle removed successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
    )


@router.post(
    "/me/payment-methods",
    response_model=APIResponse[UserResponse],
    description="Add a new payment method to the user's profile.",
)
async def add_payment_method(
    *,
    payment_in: PaymentMethodCreate,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    new_method = PaymentMethod(**payment_in.model_dump())

    if not current_user.payment_methods or new_method.is_default:
        for pm in current_user.payment_methods:
            pm.is_default = False
        new_method.is_default = True

    current_user.payment_methods.append(new_method)

    user = await user_service.update_user(
        user_id=current_user.user_id,
        user_in=UserUpdate(payment_methods=current_user.payment_methods),
    )
    return APIResponse.success_response(
        message="Payment method added successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
    )


@router.delete(
    "/me/payment-methods/{method_id}",
    response_model=APIResponse[UserResponse],
    description="Remove a payment method from the user's profile.",
)
async def remove_payment_method(
    *,
    method_id: str,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    new_methods = [pm for pm in current_user.payment_methods if pm.id != method_id]
    if len(new_methods) == len(current_user.payment_methods):
        raise HTTPException(
            status_code=404,
            detail="Payment method not found",
        )

    if (
        any(pm.id == method_id and pm.is_default for pm in current_user.payment_methods)
        and new_methods
    ):
        new_methods[0].is_default = True

    user = await user_service.update_user(
        user_id=current_user.user_id, user_in=UserUpdate(payment_methods=new_methods)
    )
    return APIResponse.success_response(
        message="Payment method removed successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
    )


@router.put(
    "/me/payment-methods/{method_id}/default",
    response_model=APIResponse[UserResponse],
    description="Set a payment method as the default.",
)
async def set_default_payment_method(
    *,
    method_id: str,
    current_user: UserInDB = Depends(get_current_user),
) -> Any:
    method_exists = any(pm.id == method_id for pm in current_user.payment_methods)
    if not method_exists:
        raise HTTPException(
            status_code=404,
            detail="Payment method not found",
        )

    for pm in current_user.payment_methods:
        pm.is_default = pm.id == method_id

    user = await user_service.update_user(
        user_id=current_user.user_id,
        user_in=UserUpdate(payment_methods=current_user.payment_methods),
    )
    return APIResponse.success_response(
        message="Default payment method updated successfully",
        code=ResponseCode.USER_UPDATED,
        data=UserResponse(**user.model_dump(), id=user.user_id),
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
