import pytest
from unittest.mock import AsyncMock, patch, MagicMock
from app.services.notification_service import NotificationService
from app.models.user import UserInDB
from datetime import datetime, timezone

@pytest.mark.asyncio
async def test_notify_admins():
    # Setup
    mock_admins = [
        UserInDB(
            _id="admin1_id",
            user_id="admin1_id",
            name="Admin One",
            email="admin1@test.com",
            password_hash="hash1",
            full_name="Admin One",
            role="admin",
            fcm_token="token1",
            created_at=datetime.now(timezone.utc),
            updated_at=datetime.now(timezone.utc)
        ),
        UserInDB(
            _id="admin2_id",
            user_id="admin2_id",
            name="Admin Two",
            email="admin2@test.com",
            password_hash="hash2",
            full_name="Admin Two",
            role="admin",
            fcm_token="token2",
            created_at=datetime.now(timezone.utc),
            updated_at=datetime.now(timezone.utc)
        )
    ]

    with patch("app.services.notification_service.user_repository.get_admins", new_callable=AsyncMock) as mock_get_admins:
        mock_get_admins.return_value = mock_admins
        
        notification_service = NotificationService()
        notification_service.send_notification = AsyncMock()

        # Execute
        await notification_service.notify_admins(
            title="Admin Alert",
            message="Test Message",
            notification_type="warning",
            payload={"key": "value"}
        )

        # Verify
        assert mock_get_admins.called
        assert notification_service.send_notification.call_count == 2
        
        # Check first call
        notification_service.send_notification.assert_any_call(
            title="Admin Alert",
            message="Test Message",
            user_id="admin1_id",
            notification_type="warning",
            payload={"key": "value"}
        )
        # Check second call
        notification_service.send_notification.assert_any_call(
            title="Admin Alert",
            message="Test Message",
            user_id="admin2_id",
            notification_type="warning",
            payload={"key": "value"}
        )
