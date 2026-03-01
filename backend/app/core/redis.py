import logging
from redis.asyncio import Redis
from app.core.config import settings

logger = logging.getLogger(__name__)


class RedisCache:
    client: Redis = None


redis_cache = RedisCache()


async def connect_to_redis():
    try:
        redis_cache.client = Redis.from_url(settings.REDIS_URL)
        await redis_cache.client.ping()
        logger.info("Successfully connected to Redis.")
    except Exception as e:
        logger.error(f"Error connecting to Redis: {e}")


async def close_redis_connection():
    if redis_cache.client:
        await redis_cache.client.aclose()
        logger.info("Closed Redis connection.")


def get_redis():
    """Dependency to yield the redis client"""
    return redis_cache.client
