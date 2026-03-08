from typing import Any, List, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Request
from sse_starlette.sse import EventSourceResponse
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.notification import NotificationResponse
from app.core.database import db
from app.core.redis import redis_cache
from datetime import datetime, timezone
import json
import asyncio
from bson import ObjectId
from loguru import logger

router = APIRouter()


@router.get("/", response_model=APIResponse[List[NotificationResponse]])
async def get_notifications(
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Retrieve notifications for the current user.
    """
    query = {
        "$or": [{"user_id": current_user.user_id}, {"user_id": None}],
        "deleted_at": None,
    }

    cursor = db.client["parkflow"].notifications.find(query).sort("created_at", -1)
    notifications = await cursor.to_list(length=100)

    serialized = []
    for n in notifications:
        n["_id"] = str(n["_id"])
        serialized.append(NotificationResponse(**n))

    return APIResponse.success_response(
        message="Notifications retrieved", data=serialized
    )


@router.patch("/{notification_id}/read", response_model=APIResponse[bool])
async def mark_notification_as_read(
    notification_id: str,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Mark a notification as read.
    """
    now = datetime.now(timezone.utc)
    result = await db.client["parkflow"].notifications.update_one(
        {"_id": notification_id, "user_id": current_user.user_id},
        {"$set": {"read_at": now, "updated_at": now}},
    )

    if result.modified_count == 0:
        return APIResponse.error_response(
            message="Notification not found or already read",
            status_code=status.HTTP_404_NOT_FOUND,
        )

    return APIResponse.success_response(
        message="Notification marked as read", data=True
    )


@router.patch("/read-all", response_model=APIResponse[int])
async def mark_all_notifications_as_read(
    current_user: Any = Depends(get_current_user),
) -> Any:
    now = datetime.now(timezone.utc)
    query = {
        "user_id": current_user.user_id,
        "read_at": None,
        "deleted_at": None,
    }

    result = await db.client["parkflow"].notifications.update_many(
        query,
        {"$set": {"read_at": now, "updated_at": now}},
    )

    return APIResponse.success_response(
        message=f"{result.modified_count} notifications marked as read",
        data=result.modified_count,
    )


@router.get("/stream")
async def notifications_stream(
    request: Request,
    current_user: Any = Depends(get_current_user),
):
    """
    SSE stream for real-time notification updates.
    """

    async def event_generator():
        pubsub = redis_cache.client.pubsub()
        await pubsub.subscribe("notification_updates")

        try:
            yield {"event": "ping", "data": "connected"}

            while True:
                if await request.is_disconnected():
                    break

                message = await pubsub.get_message(
                    ignore_subscribe_messages=True, timeout=1.0
                )

                if message:
                    try:
                        data = json.loads(message["data"])
                        # Only notify if it belongs to the current user or is global
                        target_user_id = data.get("user_id")
                        if (
                            target_user_id is None
                            or target_user_id == current_user.user_id
                        ):
                            yield {"data": json.dumps(data)}
                    except Exception as e:
                        logger.error(f"SSE Notification Error: {e}")

                await asyncio.sleep(0.1)
        except Exception as e:
            logger.error(f"SSE Notification Stream Error: {e}")
        finally:
            await pubsub.unsubscribe("notification_updates")
            await pubsub.close()

    return EventSourceResponse(event_generator())
