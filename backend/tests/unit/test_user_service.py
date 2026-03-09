import pytest
from unittest.mock import AsyncMock, patch, MagicMock
from app.services.user_service import UserService
from app.schemas.user import UserCreate
from app.core.exceptions import AppException
from app.schemas.response import ResponseCode


@pytest.mark.asyncio
async def test_create_user_success():
    with patch("app.services.user_service.user_repository") as mock_repo:
        mock_repo.get_by_email = AsyncMock(return_value=None)
        mock_created_user = MagicMock()
        mock_created_user.email = "test@example.com"
        mock_repo.create = AsyncMock(return_value=mock_created_user)

        service = UserService()
        user_in = UserCreate(
            email="test@example.com",
            password="password",
            name="Test User",
            role="driver",
            vehicles=[],
        )

        result = await service.create_user(user_in)

        assert result.email == "test@example.com"
        mock_repo.get_by_email.assert_called_once_with("test@example.com")
        mock_repo.create.assert_called_once()


@pytest.mark.asyncio
async def test_create_user_already_exists():
    with patch("app.services.user_service.user_repository") as mock_repo:
        mock_repo.get_by_email = AsyncMock(
            return_value={"email": "existing@example.com", "user_id": "123"}
        )

        service = UserService()
        user_in = UserCreate(
            email="existing@example.com",
            password="password",
            name="Existing User",
            role="driver",
            vehicles=[],
        )

        with pytest.raises(AppException) as excinfo:
            await service.create_user(user_in)

        assert excinfo.value.code == ResponseCode.USER_ALREADY_EXISTS
        assert excinfo.value.status_code == 400


@pytest.mark.asyncio
async def test_authenticate_success():
    with patch("app.services.user_service.user_repository") as mock_repo:
        with patch("app.services.user_service.verify_password", return_value=True):
            mock_user = MagicMock()
            mock_user.password_hash = "hashed_pw"
            mock_repo.get_by_email = AsyncMock(return_value=mock_user)

            service = UserService()
            result = await service.authenticate("test@example.com", "password")

            assert result == mock_user
            mock_repo.get_by_email.assert_called_once_with("test@example.com")


@pytest.mark.asyncio
async def test_authenticate_failure():
    with patch("app.services.user_service.user_repository") as mock_repo:
        mock_repo.get_by_email = AsyncMock(return_value=None)

        service = UserService()
        result = await service.authenticate("nonexistent@example.com", "password")

        assert result is None
