import pytest
from datetime import datetime, timedelta, timezone
from fastapi import status
from unittest.mock import patch, AsyncMock, MagicMock
from app.api.deps import get_current_user, get_current_admin
from app.main import app
from app.schemas.response import ResponseCode


@pytest.fixture
def override_get_current_user():
    mock_user = MagicMock()
    mock_user.user_id = "user123"
    mock_user.role = "driver"
    app.dependency_overrides[get_current_user] = lambda: mock_user
    yield mock_user
    app.dependency_overrides.clear()


@pytest.fixture
def override_auth(override_get_current_user):
    return override_get_current_user


@pytest.mark.asyncio
async def test_create_reservation_api_success(client, override_get_current_user):
    mock_user = override_get_current_user

    start_time = datetime.now(timezone.utc) + timedelta(hours=1)
    mock_res_data = {
        "_id": "65e8a7b2c9e8a7b2c9e8a7b2",
        "user_id": mock_user.user_id,
        "slot_id": "slot456",
        "start_time": start_time,
        "end_time": start_time + timedelta(hours=1),
        "vehicle": {"plate_number": "ABC-123", "type": "car"},
        "duration_minutes": 60,
        "payment_method": "card",
        "total_price": 100.0,
        "base_rate": 100.0,
        "actual_end_time": start_time + timedelta(hours=1),
        "total_billed_price": 100.0,
        "status": "active",
        "qr_code_token": "token123",
        "lot_name": "Test Lot",
        "lot_address": "123 Test St",
        "lot_latitude": 0.0,
        "lot_longitude": 0.0,
        "slot_name": "Slot A1",
        "has_rating": False,
        "created_at": datetime.now(timezone.utc),
        "updated_at": datetime.now(timezone.utc),
    }

    with patch(
        "app.api.routers.reservations.reservation_service.create_reservation",
        new_callable=AsyncMock,
    ) as mock_create:
        mock_create.return_value = mock_res_data

        response = client.post(
            "/api/v1/reservations/",
            json={
                "slot_id": "auto",
                "lot_id": "lot789",
                "start_time": start_time.isoformat(),
                "duration_minutes": 60,
                "payment_method": "card",
                "vehicle": {"plate_number": "ABC-123", "type": "car"},
            },
        )

        assert response.status_code == 200
        data = response.json()
        assert data["message"] == "Reservation created successfully"
        assert data["data"]["id"] == "65e8a7b2c9e8a7b2c9e8a7b2"


@pytest.mark.asyncio
async def test_get_my_reservations_api(client, override_get_current_user):
    mock_user = override_get_current_user

    mock_cursor = MagicMock()
    mock_cursor.sort.return_value = mock_cursor
    mock_cursor.to_list = AsyncMock(return_value=[])

    with patch("app.core.database.db.client") as mock_mongo_client:
        mock_mongo_client.__getitem__.return_value.reservations.find.return_value = (
            mock_cursor
        )

        response = client.get("/api/v1/reservations/me")
        assert response.status_code == 200

        response = client.get("/api/v1/reservations/mine")
        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS


@pytest.mark.asyncio
async def test_cancel_reservation_api(client, override_auth):
    with patch(
        "app.services.reservation_service.reservation_service.cancel_reservation",
        new_callable=AsyncMock,
    ) as mock_cancel:
        mock_res = MagicMock()
        mock_res.user_id = "user123"
        mock_cancel.return_value = mock_res

        with patch("app.core.database.db.client") as mock_client:
            mock_db = MagicMock()
            mock_client.__getitem__.return_value = mock_db
            mock_db.reservations.find_one = AsyncMock(
                return_value={"_id": "res123", "user_id": "user123"}
            )

            response = client.patch("/api/v1/reservations/res123/cancel")

            assert response.status_code == 200
            data = response.json()
            assert data["code"] == ResponseCode.SUCCESS
            mock_cancel.assert_called_once()
