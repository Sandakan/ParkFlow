import pytest
import asyncio
from typing import Generator
from motor.motor_asyncio import AsyncIOMotorClient
from mongomock_motor import AsyncMongoMockClient
from fakeredis import FakeRedis
from fastapi.testclient import TestClient
from unittest.mock import patch, AsyncMock


@pytest.fixture(autouse=True)
def mock_app_startup():
    with patch("app.main.connect_to_mongo", new_callable=AsyncMock), patch(
        "app.main.connect_to_redis", new_callable=AsyncMock
    ), patch("app.main.close_mongo_connection", new_callable=AsyncMock), patch(
        "app.main.close_redis_connection", new_callable=AsyncMock
    ), patch(
        "app.main.inference_manager.start_all", new_callable=AsyncMock
    ), patch(
        "app.main.inference_manager.stop_all", new_callable=AsyncMock
    ):
        yield


from app.main import app
from app.core.database import db
from app.core.redis import redis_cache


# Mock MongoDB
@pytest.fixture(autouse=True)
async def mock_mongodb(monkeypatch):
    mock_client = AsyncMongoMockClient()
    monkeypatch.setattr(db, "client", mock_client)
    # mock if it re-initializes
    monkeypatch.setattr(
        "app.core.database.AsyncIOMotorClient", lambda *args, **kwargs: mock_client
    )
    return mock_client


# Mock Redis
@pytest.fixture(autouse=True)
def mock_redis(monkeypatch):
    mock_redis_client = FakeRedis(decode_responses=True)
    monkeypatch.setattr(redis_cache, "client", mock_redis_client)
    monkeypatch.setattr(
        "app.core.redis.Redis.from_url", lambda *args, **kwargs: mock_redis_client
    )
    return mock_redis_client


# FastAPI
@pytest.fixture
def client() -> Generator:
    with TestClient(app) as c:
        yield c


# Asyncio event loop fixture
@pytest.fixture(scope="session")
def event_loop():
    try:
        loop = asyncio.get_running_loop()
    except RuntimeError:
        loop = asyncio.new_event_loop()
    yield loop
    loop.close()
