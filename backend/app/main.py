import os
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.core.database import connect_to_mongo, close_mongo_connection, db
from app.core.redis import connect_to_redis, close_redis_connection, redis_cache
from app.api.routers import auth, users, inference
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from starlette.exceptions import HTTPException as StarletteHTTPException
from app.schemas.response import APIResponse, ResponseCode


@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_to_mongo()

    await connect_to_redis()

    yield

    await close_mongo_connection()
    await close_redis_connection()


app = FastAPI(title=settings.PROJECT_NAME, version=settings.VERSION, lifespan=lifespan)


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException):
    code = ResponseCode.ERROR
    if exc.status_code == 404:
        code = ResponseCode.NOT_FOUND
    elif exc.status_code == 401:
        code = ResponseCode.UNAUTHORIZED
    elif exc.status_code == 403:
        code = ResponseCode.FORBIDDEN

    return APIResponse.error_response(
        code=code,
        message=str(exc.detail),
        status_code=exc.status_code,
    )


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return APIResponse.error_response(
        code=ResponseCode.VALIDATION_ERROR,
        message=f"Validation Error: {str(exc.errors())}",
        status_code=422,
    )


@app.exception_handler(Exception)
async def generic_exception_handler(request: Request, exc: Exception):
    return APIResponse.error_response(
        code=ResponseCode.INTERNAL_SERVER_ERROR,
        message="An unexpected error occurred.",
        status_code=500,
    )


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(inference.router, prefix="/api/v1/inference", tags=["AI Inference"])


@app.get("/", response_model=APIResponse[dict])
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

    return APIResponse.success_response(
        message="Welcome to ParkFlow AI Core",
        data={
            "mongodb_status": mongo_status,
            "redis_status": redis_status,
        },
    )
