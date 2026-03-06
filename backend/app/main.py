import os
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, FileResponse
from fastapi.exceptions import RequestValidationError
from starlette.exceptions import HTTPException as StarletteHTTPException

# Configure logging first so all subsequent imports route through loguru
from app.core.logging import logger, setup_logging

setup_logging()

from app.core.config import settings
from app.core.database import connect_to_mongo, close_mongo_connection, db
from app.core.redis import connect_to_redis, close_redis_connection, redis_cache
from app.core.exceptions import AppException
from app.ai.inference_manager import inference_manager
from app.api.routers import (
    auth,
    users,
    inference,
    parking,
    cameras,
    analytics,
    reservations,
    settings as settings_router,
)

from app.schemas.response import APIResponse, ResponseCode


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Starting ParkFlow API...")
    await connect_to_mongo()
    await connect_to_redis()
    logger.info("ParkFlow API started successfully.")

    host_port = os.getenv("HOST_PORT", "8200")
    logger.info(
        "\n"
        f"Base URL  : http://localhost:{host_port} \n"
        f"API Docs  : http://localhost:{host_port}/docs \n"
        f"Health    : http://localhost:{host_port}/ \n"
    )

    await inference_manager.start_all()

    yield

    logger.info("Shutting down ParkFlow API...")
    await inference_manager.stop_all()
    await close_mongo_connection()
    await close_redis_connection()


app = FastAPI(title=settings.PROJECT_NAME, version=settings.VERSION, lifespan=lifespan)


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    response = APIResponse.error_response(
        code=ResponseCode.VALIDATION_ERROR,
        message=f"Validation Error: {str(exc.errors())}",
        status_code=422,
    )
    return JSONResponse(status_code=422, content=response.model_dump())


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException):
    code = ResponseCode.ERROR
    if exc.status_code == 404:
        code = ResponseCode.NOT_FOUND
    elif exc.status_code == 401:
        code = ResponseCode.UNAUTHORIZED
    elif exc.status_code == 403:
        code = ResponseCode.FORBIDDEN

    response = APIResponse.error_response(
        code=code,
        message=str(exc.detail),
        status_code=exc.status_code,
    )
    return JSONResponse(status_code=exc.status_code, content=response.model_dump())


@app.exception_handler(AppException)
async def app_exception_handler(request: Request, exc: AppException):
    response = APIResponse.error_response(
        code=exc.code,
        message=exc.message,
        status_code=exc.status_code,
    )
    return JSONResponse(status_code=exc.status_code, content=response.model_dump())


@app.exception_handler(Exception)
async def generic_exception_handler(request: Request, exc: Exception):
    response = APIResponse.error_response(
        code=ResponseCode.INTERNAL_SERVER_ERROR,
        message="An unexpected error occurred.",
        status_code=500,
    )
    return JSONResponse(status_code=500, content=response.model_dump())


app.add_middleware(
    CORSMiddleware,
    # TODO: Remove this in production when webrtc_test.html testing is not needed
    allow_origins=["null"],
    allow_origin_regex=r"http://localhost:?\d*|http://127.0.0.1:?\d*",
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(inference.router, prefix="/api/v1/inference", tags=["AI Inference"])
app.include_router(parking.router, prefix="/api/v1/parking", tags=["Parking"])
app.include_router(cameras.router, prefix="/api/v1/cameras", tags=["Cameras"])
app.include_router(analytics.router, prefix="/api/v1/analytics", tags=["Analytics"])
app.include_router(
    reservations.router, prefix="/api/v1/reservations", tags=["Reservations"]
)
app.include_router(settings_router.router, prefix="/api/v1/settings", tags=["Settings"])


@app.get("/favicon.ico", include_in_schema=False)
async def favicon():
    return FileResponse(os.path.join("app", "static", "favicon.ico"))


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
