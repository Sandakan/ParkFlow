import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.api.deps import get_current_user, get_current_admin
from app.main import app
from app.schemas.response import ResponseCode


@pytest.fixture
def override_get_current_user():
    mock_user = MagicMock()
    mock_user.user_id = "user123"
    app.dependency_overrides[get_current_user] = lambda: mock_user
    yield mock_user
    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_get_parking_lots_api(client, override_get_current_user):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_lots_cursor = MagicMock()
        lots = [
            {"_id": "lot123", "name": "Main Lot", "location": {"coordinates": [0, 0]}}
        ]
        mock_lots_cursor.to_list = AsyncMock(return_value=lots)
        mock_db.parking_lots.find.return_value = mock_lots_cursor

        mock_db.parking_slots.count_documents = AsyncMock(return_value=10)
        mock_db.cameras.count_documents = AsyncMock(return_value=2)

        response = client.get("/api/v1/parking/lots")

        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS
        assert len(data["data"]["lots"]) == 1
        assert data["data"]["lots"][0]["name"] == "Main Lot"


@pytest.mark.asyncio
async def test_get_parking_slots_api(client, override_get_current_user):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_slots_cursor = MagicMock()
        slots = [{"_id": "slot123", "slot_number": "A1", "lot_id": "lot123"}]
        mock_slots_cursor.to_list = AsyncMock(return_value=slots)
        mock_db.parking_slots.find.return_value = mock_slots_cursor

        mock_db.reservations.find_one = AsyncMock(return_value=None)

        response = client.get("/api/v1/parking/slots?lot_id=lot123")

        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS
        assert len(data["data"]["slots"]) == 1
        assert data["data"]["slots"][0]["name"] == "A1"


@pytest.fixture
def override_get_current_admin():
    mock_admin = MagicMock()
    mock_admin.user_id = "admin123"
    mock_admin.role = "admin"
    app.dependency_overrides[get_current_admin] = lambda: mock_admin
    yield mock_admin
    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_create_parking_lot_api(client, override_get_current_admin):
    lot_in = {
        "name": "Admin Lot",
        "address": "123 Street",
        "latitude": 6.9,
        "longitude": 79.8,
        "base_rate": 100.0,
        "slot_width_meters": 2.5,
        "slot_length_meters": 5.0,
    }

    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_result = MagicMock()
        mock_result.inserted_id = "lot123"
        mock_db.parking_lots.insert_one = AsyncMock(return_value=mock_result)

        response = client.post("/api/v1/parking/lots", json=lot_in)

        assert response.status_code == 201
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS
        assert data["data"]["id"] == "lot123"


@pytest.mark.asyncio
async def test_delete_parking_slot_api(client, override_get_current_admin):
    valid_id = "65e8a7b2c9e8a7b2c9e8a7b2"
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_result = MagicMock()
        mock_result.matched_count = 1
        mock_db.parking_slots.update_one = AsyncMock(return_value=mock_result)
        mock_db.camera_slot_mappings.update_many = AsyncMock(return_value=mock_result)

        response = client.delete(f"/api/v1/parking/slots/{valid_id}")

        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS
