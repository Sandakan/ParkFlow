import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.services.notification_service import NotificationService


@pytest.fixture
def notification_service():
    return NotificationService()


@pytest.mark.asyncio
async def test_send_notification(notification_service):
    with patch("app.core.database.db.client") as mock_client:
        with patch("app.core.redis.redis_cache.client") as mock_redis:
            mock_res = MagicMock()
            mock_res.inserted_id = "notif123"

            mock_db = MagicMock()
            mock_client.__getitem__.return_value = mock_db
            mock_db.notifications.insert_one = AsyncMock(return_value=mock_res)

            mock_redis.publish = AsyncMock()

            with patch(
                "app.services.notification_service.user_repository.get_by_id",
                new_callable=AsyncMock,
            ) as mock_get_user:
                mock_get_user.return_value = None

                await notification_service.send_notification(
                    title="Test Title",
                    message="Test Message",
                    user_id="user123",
                    notification_type="info",
                    payload={"test": "data"},
                )

            mock_db.notifications.insert_one.assert_called_once()
            mock_redis.publish.assert_called_once()
