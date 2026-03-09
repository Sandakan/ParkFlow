import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.services.email_service import email_service


@pytest.mark.asyncio
async def test_send_templated_email():
    with patch(
        "app.services.email_service.FastMail.send_message", new_callable=AsyncMock
    ) as mock_send:
        await email_service.send_templated_email(
            subject="Test Subject",
            recipients=["test@example.com"],
            title="Test Title",
            content="<p>Test Content</p>",
        )
        mock_send.assert_called_once()
        args, kwargs = mock_send.call_args
        message = args[0]
        assert "Test Subject" == message.subject

        recipient_emails = [
            r if isinstance(r, str) else r.email for r in message.recipients
        ]
        assert "test@example.com" in recipient_emails

        assert "Test Title" in message.body
        assert "Test Content" in message.body
