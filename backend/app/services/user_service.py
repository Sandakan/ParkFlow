from typing import Optional, Any
from fastapi import HTTPException, status
from app.models.user import UserInDB
from app.schemas.user import UserCreate, UserUpdate
from app.schemas.response import ResponseCode
from app.core.exceptions import AppException
from app.repositories.user_repository import user_repository
from app.core.security import get_password_hash, verify_password


class UserService:
    async def get_user_by_email(self, email: str) -> Optional[UserInDB]:
        return await user_repository.get_by_email(email)

    async def get_user(self, user_id: str) -> Optional[UserInDB]:
        return await user_repository.get_by_id(user_id)

    async def create_user(self, user_in: UserCreate) -> UserInDB:
        user = await self.get_user_by_email(email=user_in.email)
        if user:
            raise AppException(
                message="The user with this email already exists in the system.",
                code=ResponseCode.USER_ALREADY_EXISTS,
                status_code=400,
            )
        user_db = UserInDB(
            _id="temp_id",
            name=user_in.name,
            email=user_in.email,
            password_hash=get_password_hash(user_in.password),
            role=user_in.role,
            vehicles=user_in.vehicles,
        )
        created_user = await user_repository.create(user_db)
        return created_user

    async def update_user(
        self, user_id: str, user_in: UserUpdate
    ) -> Optional[UserInDB]:
        user = await self.get_user(user_id)
        if not user:
            raise HTTPException(
                status_code=404,
                detail="User not found",
            )
        update_data = user_in.model_dump(exclude_unset=True)
        if "password" in update_data:
            hashed_password = get_password_hash(update_data["password"])
            del update_data["password"]
            update_data["password_hash"] = hashed_password

        if "email" in update_data:
            existing_user = await self.get_user_by_email(update_data["email"])
            if existing_user and existing_user.user_id != user_id:
                raise HTTPException(
                    status_code=400,
                    detail="Email already registered to another user",
                )

        updated_user = await user_repository.update(user_id, update_data)
        return updated_user

    async def authenticate(self, email: str, password: str) -> Optional[UserInDB]:
        user = await self.get_user_by_email(email)
        if not user:
            return None
        if not verify_password(password, user.password_hash):
            return None
        return user

    async def reset_password(self, user_id: str, new_password: str) -> Optional[UserInDB]:
        hashed_password = get_password_hash(new_password)
        updated_user = await user_repository.update(user_id, {"password_hash": hashed_password})
        return updated_user


user_service = UserService()
