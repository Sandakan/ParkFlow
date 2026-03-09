import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.models.user import UserInDB, VehicleDetails
from app.schemas.response import ResponseCode
from app.main import app
from app.api.deps import get_current_user, get_current_admin
from datetime import datetime, timezone

@pytest.fixture
def mock_user():
    user = UserInDB(
        _id="user123",
        name="Test User",
        email="test@example.com",
        password_hash="hash",
        role="driver",
        vehicles=[],
        payment_methods=[]
    )
    return user

@pytest.fixture
def override_auth(mock_user):
    app.dependency_overrides[get_current_user] = lambda: mock_user
    yield mock_user
    app.dependency_overrides.clear()

@pytest.mark.asyncio
async def test_create_user_api(client):
    user_in = {
        "email": "newuser@example.com",
        "name": "New User",
        "password": "strongpassword",
        "role": "driver"
    }
    
    with patch("app.services.user_service.user_service.create_user", new_callable=AsyncMock) as mock_create:
        mock_user_obj = MagicMock()
        mock_user_obj.user_id = "new123"
        mock_user_obj.model_dump.return_value = {
            "name": "New User",
            "email": "newuser@example.com",
            "role": "driver",
            "vehicles": [],
            "payment_methods": [],
            "user_id": "new123",
            "created_at": datetime.now(timezone.utc)
        }
        mock_create.return_value = mock_user_obj
        
        response = client.post("/api/v1/users/", json=user_in)
        
        assert response.status_code == 201
        data = response.json()
        assert data["code"] == ResponseCode.USER_CREATED
        assert data["data"]["users"][0]["email"] == "newuser@example.com"

@pytest.mark.asyncio
async def test_read_user_me_api(client, override_auth):
    response = client.get("/api/v1/users/me")
    
    assert response.status_code == 200
    data = response.json()
    assert data["code"] == ResponseCode.USER_FETCHED
    assert data["data"]["email"] == "test@example.com"

@pytest.mark.asyncio
async def test_update_user_me_api(client, override_auth):
    update_in = {"name": "Updated Name"}
    
    with patch("app.services.user_service.user_service.update_user", new_callable=AsyncMock) as mock_update:
        mock_user_obj = MagicMock()
        mock_user_obj.user_id = "user123"
        mock_user_obj.model_dump.return_value = {
            "name": "Updated Name",
            "email": "test@example.com",
            "role": "driver",
            "vehicles": [],
            "payment_methods": [],
            "user_id": "user123",
            "created_at": datetime.now(timezone.utc)
        }
        mock_update.return_value = mock_user_obj
        
        response = client.put("/api/v1/users/user123", json=update_in)
        
        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.USER_UPDATED
        assert data["data"]["name"] == "Updated Name"

@pytest.mark.asyncio
async def test_add_vehicle_api(client, override_auth, mock_user):
    vehicle_in = {
        "plate_number": "ABC-1234",
        "type": "car"
    }
    
    with patch("app.services.user_service.user_service.update_user", new_callable=AsyncMock) as mock_update:
        mock_user_obj = MagicMock()
        mock_user_obj.user_id = "user123"
        mock_user_obj.model_dump.return_value = {
            "name": "Test User",
            "email": "test@example.com",
            "role": "driver",
            "vehicles": [vehicle_in],
            "payment_methods": [],
            "user_id": "user123",
            "created_at": datetime.now(timezone.utc)
        }
        mock_update.return_value = mock_user_obj
        
        response = client.post("/api/v1/users/me/vehicles", json=vehicle_in)
        
        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.USER_UPDATED
        assert data["data"]["vehicles"][0]["plate_number"] == "ABC-1234"

@pytest.mark.asyncio
async def test_add_payment_method_api(client, override_auth, mock_user):
    payment_in = {
        "type": "card",
        "provider": "visa",
        "last4": "4242",
        "is_default": True
    }
    
    with patch("app.services.user_service.user_service.update_user", new_callable=AsyncMock) as mock_update:
        mock_user_obj = MagicMock()
        mock_user_obj.user_id = "user123"
        mock_user_obj.model_dump.return_value = {
            "name": "Test User",
            "email": "test@example.com",
            "role": "driver",
            "vehicles": [],
            "payment_methods": [{"id": "pm_1", "type": "card", "provider": "visa", "last4": "4242", "is_default": True}],
            "user_id": "user123",
            "created_at": datetime.now(timezone.utc)
        }
        mock_update.return_value = mock_user_obj
        
        response = client.post("/api/v1/users/me/payment-methods", json=payment_in)
        
        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.USER_UPDATED
        assert data["data"]["payment_methods"][0]["last4"] == "4242"
