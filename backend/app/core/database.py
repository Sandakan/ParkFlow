import logging
from motor.motor_asyncio import AsyncIOMotorClient
from app.core.config import settings

logger = logging.getLogger(__name__)


class Database:
    client: AsyncIOMotorClient = None


db = Database()


async def connect_to_mongo():
    try:
        db.client = AsyncIOMotorClient(settings.MONGODB_URL)
        await db.client.admin.command("ping")
        logger.info("Successfully connected to MongoDB.")
    except Exception as e:
        logger.error(f"Error connecting to MongoDB: {e}")


async def close_mongo_connection():
    if db.client:
        db.client.close()
        logger.info("Closed MongoDB connection.")


def get_database():
    """Dependency to yield the database client"""
    return db.client


async def update_camera_status(camera_id: str, is_alive: bool):
    from bson import ObjectId
    from datetime import datetime, timezone

    try:
        await db.client["parkflow"].cameras.update_one(
            {"_id": ObjectId(camera_id)},
            {
                "$set": {
                    "is_alive": is_alive,
                    "last_active": datetime.now(timezone.utc) if is_alive else None,
                }
            },
        )
    except Exception as e:
        print(f"Failed to update camera status for {camera_id}: {e}")


async def get_inference_settings():
    from app.models.settings import InferenceSettingsInDB

    settings_doc = await db.client["parkflow"].settings.find_one({"_id": "inference"})
    if not settings_doc:
        return InferenceSettingsInDB()
    return InferenceSettingsInDB(**settings_doc)
