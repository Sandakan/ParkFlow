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
