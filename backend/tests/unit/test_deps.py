import pytest
from fastapi import HTTPException
from unittest.mock import patch, AsyncMock, MagicMock
from app.api.deps import get_current_user, get_current_admin
from app.core.security import create_access_token

@pytest.mark.asyncio
async def test_get_current_user_success():
    token = create_access_token(subject="user123")
    mock_user = MagicMock()
    
    with patch("app.api.deps.user_service.get_user", new_callable=AsyncMock) as mock_get_user:
        mock_get_user.return_value = mock_user
        result = await get_current_user(token)
        assert result == mock_user
        mock_get_user.assert_called_once_with(user_id="user123")

@pytest.mark.asyncio
async def test_get_current_user_not_found():
    token = create_access_token(subject="nonexistent")
    
    with patch("app.api.deps.user_service.get_user", new_callable=AsyncMock) as mock_get_user:
        mock_get_user.return_value = None
        with pytest.raises(HTTPException) as excinfo:
            await get_current_user(token)
        assert excinfo.value.status_code == 404

@pytest.mark.asyncio
async def test_get_current_user_invalid_token():
    with pytest.raises(HTTPException) as excinfo:
        await get_current_user("invalid-token")
    assert excinfo.value.status_code == 403

@pytest.mark.asyncio
async def test_get_current_admin_success():
    mock_user = MagicMock()
    mock_user.role = "admin"
    result = await get_current_admin(mock_user)
    assert result == mock_user

@pytest.mark.asyncio
async def test_get_current_admin_forbidden():
    mock_user = MagicMock()
    mock_user.role = "driver"
    with pytest.raises(HTTPException) as excinfo:
        await get_current_admin(mock_user)
    assert excinfo.value.status_code == 403
