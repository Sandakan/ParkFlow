import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from fastapi import status
from app.schemas.response import ResponseCode


@pytest.mark.asyncio
async def test_forgot_password_api_success(client):
    with patch(
        "app.services.user_service.user_service.get_user_by_email",
        new_callable=AsyncMock,
    ) as mock_get_user:
        mock_get_user.return_value = MagicMock(email="test@example.com")

        with patch(
            "app.core.redis.redis_cache.client.setex", new_callable=AsyncMock
        ) as mock_redis_set:
            with patch(
                "app.services.email_service.email_service.send_templated_email",
                new_callable=AsyncMock,
            ) as mock_send_email:

                response = client.post(
                    "/api/v1/auth/forgot-password", json={"email": "test@example.com"}
                )

                assert response.status_code == 200
                data = response.json()
                assert data["code"] == ResponseCode.OTP_SENT
                mock_redis_set.assert_called_once()
                mock_send_email.assert_called_once()


@pytest.mark.asyncio
async def test_verify_otp_api_success(client):
    with patch(
        "app.core.redis.redis_cache.client.get", new_callable=AsyncMock
    ) as mock_redis_get:
        mock_redis_get.return_value = b"123456"

        response = client.post(
            "/api/v1/auth/verify-otp",
            json={"email": "test@example.com", "otp": "123456"},
        )

        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.OTP_VERIFIED


@pytest.mark.asyncio
async def test_verify_otp_api_invalid(client):
    with patch(
        "app.core.redis.redis_cache.client.get", new_callable=AsyncMock
    ) as mock_redis_get:
        mock_redis_get.return_value = b"123456"

        response = client.post(
            "/api/v1/auth/verify-otp",
            json={"email": "test@example.com", "otp": "wrong"},
        )

        assert response.status_code == 400 or response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.INVALID_OTP


@pytest.mark.asyncio
async def test_reset_password_api_success(client):
    with patch(
        "app.core.redis.redis_cache.client.get", new_callable=AsyncMock
    ) as mock_redis_get:
        mock_redis_get.return_value = b"123456"

        with patch(
            "app.services.user_service.user_service.get_user_by_email",
            new_callable=AsyncMock,
        ) as mock_get_user:
            mock_user = MagicMock()
            mock_user.user_id = "user123"
            mock_get_user.return_value = mock_user

            with patch(
                "app.services.user_service.user_service.reset_password",
                new_callable=AsyncMock,
            ) as mock_reset:
                with patch(
                    "app.core.redis.redis_cache.client.delete", new_callable=AsyncMock
                ) as mock_redis_del:

                    response = client.post(
                        "/api/v1/auth/reset-password",
                        json={
                            "email": "test@example.com",
                            "otp": "123456",
                            "password": "new_password",
                        },
                    )

                    assert response.status_code == 200
                    data = response.json()
                    assert data["code"] == ResponseCode.PASSWORD_RESET_SUCCESS
                    mock_reset.assert_called_once_with("user123", "new_password")
                    mock_redis_del.assert_called_once()
