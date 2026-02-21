import os
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from motor.motor_asyncio import AsyncIOMotorClient
from redis.asyncio import Redis

# Database and Redis clients
mongodb_client = None
redis_client = None

MONGODB_URL = os.getenv("MONGODB_URL", "mongodb://localhost:27017/parkflow")
REDIS_URL = os.getenv("REDIS_URL", "redis://redis:6379")


@asynccontextmanager
async def lifespan(app: FastAPI):
    global mongodb_client, redis_client

    # Initialize MongoDB client
    try:
        mongodb_client = AsyncIOMotorClient(MONGODB_URL)
        # Send a ping to confirm a successful connection
        await mongodb_client.admin.command("ping")
        print("Successfully connected to MongoDB.")
    except Exception as e:
        print(f"Error connecting to MongoDB: {e}")

    # Initialize Redis client
    try:
        redis_client = Redis.from_url(REDIS_URL)
        await redis_client.ping()
        print("Successfully connected to Redis.")
    except Exception as e:
        print(f"Error connecting to Redis: {e}")

    yield

    # Disconnect
    if mongodb_client:
        mongodb_client.close()
    if redis_client:
        await redis_client.aclose()


app = FastAPI(title="ParkFlow API", version="1.0.0", lifespan=lifespan)

# CORS (Allow Flutter to talk to Backend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def read_root():
    # Check current status
    mongo_status = "Connected" if mongodb_client else "Disconnected"
    redis_status = "Connected" if redis_client else "Disconnected"

    try:
        if mongodb_client:
            await mongodb_client.admin.command("ping")
    except:
        mongo_status = "Error"

    try:
        if redis_client:
            await redis_client.ping()
    except:
        redis_status = "Error"

    return {
        "message": "Welcome to ParkFlow AI Core",
        "mongodb_status": mongo_status,
        "redis_status": redis_status,
    }
