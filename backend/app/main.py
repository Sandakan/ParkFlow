import os
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.core.database import connect_to_mongo, close_mongo_connection, db
from app.core.redis import connect_to_redis, close_redis_connection, redis_cache
from app.api.routers import auth, users


@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_to_mongo()

    await connect_to_redis()

    yield

    await close_mongo_connection()
    await close_redis_connection()


app = FastAPI(title=settings.PROJECT_NAME, version=settings.VERSION, lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])


@app.get("/")
async def read_root():
    mongo_status = "Connected" if db.client else "Disconnected"
    redis_status = "Connected" if redis_cache.client else "Disconnected"

    try:
        if db.client:
            await db.client.admin.command("ping")
    except Exception:
        mongo_status = "Error"

    try:
        if redis_cache.client:
            await redis_cache.client.ping()
    except Exception:
        redis_status = "Error"

    return {
        "message": "Welcome to ParkFlow AI Core",
        "mongodb_status": mongo_status,
        "redis_status": redis_status,
    }
