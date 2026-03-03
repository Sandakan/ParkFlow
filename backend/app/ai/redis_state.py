from typing import Optional
from redis.asyncio import Redis
from app.core.logging import logger


async def push_detection(
    redis: Redis,
    camera_id: str,
    mapping_id: str,
    is_occupied: bool,
    buffer_size: int = 30,
):
    """
    Pushes a raw detection result (1 or 0) to a Redis list buffer and trims it.
    """
    key = f"buffer:{camera_id}:{mapping_id}"
    val = "1" if is_occupied else "0"
    try:
        await redis.lpush(key, val)
        await redis.ltrim(key, 0, buffer_size - 1)

        await redis.expire(key, 3600)  # 1 hour
    except Exception as e:
        logger.error(f"Redis error in push_detection: {e}")


async def get_stable_state(
    redis: Redis, camera_id: str, mapping_id: str, threshold: int
) -> Optional[bool]:
    """
    Checks if the most recent 'threshold' frames in the buffer are consistently the same.
    Returns:
        True if the last 'threshold' frames are all '1'
        False if the last 'threshold' frames are all '0'
        None otherwise
    """
    key = f"buffer:{camera_id}:{mapping_id}"
    try:
        items = await redis.lrange(key, 0, threshold - 1)
        if len(items) < threshold:
            return None

        # Convert bytes to ints
        values = [int(i) for i in items]
        avg = sum(values) / len(values)

        if avg == 1.0:
            return True
        if avg == 0.0:
            return False

        return None
    except Exception as e:
        logger.error(f"Redis error in get_stable_state: {e}")
        return None


async def get_confirmed_state(redis: Redis, camera_id: str, mapping_id: str) -> bool:
    key = f"camera:{camera_id}:state"

    try:
        val = await redis.hget(key, mapping_id)
        return val == b"1"
    except Exception as e:
        logger.error(f"Redis error in get_confirmed_state: {e}")
        return False


async def set_confirmed_state(
    redis: Redis, camera_id: str, mapping_id: str, is_occupied: bool
):
    key = f"camera:{camera_id}:state"
    val = "1" if is_occupied else "0"

    try:
        await redis.hset(key, mapping_id, val)
    except Exception as e:
        logger.error(f"Redis error in set_confirmed_state: {e}")
