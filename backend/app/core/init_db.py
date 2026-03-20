import asyncio
import logging
from motor.motor_asyncio import AsyncIOMotorClient
import pymongo
import sys
import os
from datetime import datetime, timezone

# Add the project root to the sys.path to run the file independently
sys.path.append(
    os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)

from app.core.config import settings
from app.core.security import get_password_hash

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


async def init_db():
    logger.info("Initializing MongoDB collections and indexes...")
    try:
        client = AsyncIOMotorClient(settings.MONGODB_URL)

        db_name = settings.MONGODB_URL.split("/")[-1].split("?")[0]
        if not db_name or db_name == "localhost:27017":
            db_name = "parkflow"

        db = client[db_name]

        logger.info("Setting up 'users' collection...")
        await db.users.create_index("email", unique=True)
        await db.users.create_index("role")

        logger.info("Setting up 'parking_lots' collection...")
        await db.parking_lots.create_index([("location", pymongo.GEOSPHERE)])

        logger.info("Setting up 'parking_slots' collection...")
        await db.parking_slots.create_index("lot_id")
        await db.parking_slots.create_index(
            [("lot_id", pymongo.ASCENDING), ("slot_number", pymongo.ASCENDING)],
            unique=True,
        )
        await db.parking_slots.create_index("status")

        logger.info("Setting up 'reservations' collection...")
        await db.reservations.create_index("user_id")
        await db.reservations.create_index("slot_id")
        await db.reservations.create_index("status")
        await db.reservations.create_index("qr_code_token", unique=True, sparse=True)

        logger.info("Setting up 'occupancy_logs' collection...")
        await db.occupancy_logs.create_index("slot_id")
        await db.occupancy_logs.create_index(
            "timestamp", expireAfterSeconds=60 * 60 * 24 * 30
        )
        await db.occupancy_logs.create_index(
            [("slot_id", pymongo.ASCENDING), ("timestamp", pymongo.DESCENDING)]
        )

        logger.info("Setting up 'notifications' collection...")
        await db.notifications.create_index("user_id")
        await db.notifications.create_index(
            "created_at", expireAfterSeconds=60 * 60 * 24 * 7
        )  # 7 days TTL

        logger.info("Setting up 'cameras' collection...")
        await db.cameras.create_index("lot_id")

        logger.info("Setting up 'camera_slot_mappings' collection...")
        await db.camera_slot_mappings.create_index("camera_id")
        await db.camera_slot_mappings.create_index("slot_id")
        await db.camera_slot_mappings.create_index(
            [("camera_id", pymongo.ASCENDING), ("slot_id", pymongo.ASCENDING)],
            unique=True,
        )

        logger.info("Setting up 'ratings' collection...")
        await db.ratings.create_index("reservation_id", unique=True)
        await db.ratings.create_index("user_id")
        await db.ratings.create_index("lot_id")

        # Create default admin user
        admin_email = os.getenv("ADMIN_EMAIL", "admin@gmail.com")
        admin_password = os.getenv("ADMIN_PASSWORD", "Admin@123")

        admin_user = await db.users.find_one({"email": admin_email})
        if not admin_user:
            logger.info(f"Creating default admin user: {admin_email}")
            await db.users.insert_one(
                {
                    "name": "System Admin",
                    "email": admin_email,
                    "password_hash": get_password_hash(admin_password),
                    "role": "admin",
                    "vehicles": [],
                    "payment_methods": [],
                    "created_at": datetime.now(timezone.utc),
                    "updated_at": datetime.now(timezone.utc),
                }
            )
        else:
            logger.info("Admin user already exists.")

        logger.info("Database initialization completed successfully.")
    except Exception as e:
        logger.error(f"Error initializing database: {e}")
    finally:
        if "client" in locals():
            client.close()


if __name__ == "__main__":
    asyncio.run(init_db())
