from typing import Optional, List
from bson import ObjectId
from app.core.database import db
from app.models.user import UserInDB


class UserRepository:
    @property
    def collection(self):
        return db.client["parkflow"]["users"] if db.client else None

    async def get_by_email(self, email: str) -> Optional[UserInDB]:
        if self.collection is None:
            return None
        document = await self.collection.find_one({"email": email})
        if document:
            document["_id"] = str(document["_id"])
            return UserInDB(**document)
        return None

    async def get_by_id(self, user_id: str) -> Optional[UserInDB]:
        if self.collection is None:
            return None
        try:
            document = await self.collection.find_one({"_id": ObjectId(user_id)})
            if document:
                document["_id"] = str(document["_id"])
                return UserInDB(**document)
        except Exception:
            return None
        return None

    async def create(self, user: UserInDB) -> UserInDB:
        user_dict = user.model_dump(by_alias=True, exclude={"user_id"})
        result = await self.collection.insert_one(user_dict)
        user.user_id = str(result.inserted_id)
        return user

    async def update(self, user_id: str, update_data: dict) -> Optional[UserInDB]:
        if self.collection is None:
            return None
        try:
            result = await self.collection.find_one_and_update(
                {"_id": ObjectId(user_id)}, {"$set": update_data}, return_document=True
            )
            if result:
                result["_id"] = str(result["_id"])
                return UserInDB(**result)
        except Exception:
            return None
        return None

    async def delete(self, user_id: str) -> bool:
        if self.collection is None:
            return False
        try:
            result = await self.collection.delete_one({"_id": ObjectId(user_id)})
            return result.deleted_count > 0
        except Exception:
            return False


user_repository = UserRepository()
