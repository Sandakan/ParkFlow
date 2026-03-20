import pytest
from datetime import datetime, timedelta, timezone
from unittest.mock import patch, AsyncMock, MagicMock
from bson import ObjectId
from app.services.reservation_service import ReservationService
from app.schemas.reservation import CreateReservationRequest
from app.core.exceptions import AppException
from app.schemas.response import ResponseCode


@pytest.fixture
def reservation_service():
    return ReservationService()


@pytest.mark.asyncio
async def test_has_overlapping_reservation(reservation_service):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.reservations.count_documents = AsyncMock(return_value=1)

        start = datetime.now(timezone.utc)
        end = start + timedelta(hours=1)

        result = await reservation_service.has_overlapping_reservation(
            "65e8a7b2c9e8a7b2c9e8a7b0", start, end
        )
        assert result is True
        mock_db.reservations.count_documents.assert_called_once()


@pytest.mark.asyncio
async def test_find_available_slot(reservation_service):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_cursor = MagicMock()
        slots = [
            {
                "_id": ObjectId("65e8a7b2c9e8a7b2c9e8a7b1"),
                "lot_id": "65e8a7b2c9e8a7b2c9e8a7b2",
                "slot_number": "A1",
            }
        ]
        mock_cursor.to_list = AsyncMock(return_value=slots)
        mock_db.parking_slots.find.return_value = mock_cursor

        with patch.object(
            reservation_service, "has_overlapping_reservation", return_value=False
        ):
            result = await reservation_service.find_available_slot(
                "65e8a7b2c9e8a7b2c9e8a7b2", datetime.now(), datetime.now()
            )
            assert result == slots[0]


@pytest.mark.asyncio
async def test_create_reservation_past_time(reservation_service):
    valid_id = "65e8a7b2c9e8a7b2c9e8a7b1"
    request = CreateReservationRequest(
        lot_id="65e8a7b2c9e8a7b2c9e8a7b2",
        slot_id=valid_id,
        start_time=datetime.now(timezone.utc) - timedelta(hours=10),  # Far in the past
        duration_minutes=60,
        payment_method="card",
        vehicle={"plate_number": "ABC-123", "type": "car"},
    )

    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_db.parking_slots.find_one = AsyncMock(
            return_value={"lot_id": "65e8a7b2c9e8a7b2c9e8a7b2", "slot_number": "A1"}
        )
        mock_db.parking_lots.find_one = AsyncMock(
            return_value={
                "base_rate": 10.0,
                "_id": ObjectId("65e8a7b2c9e8a7b2c9e8a7b2"),
                "name": "Test Lot",
            }
        )

        with patch.object(
            reservation_service, "has_overlapping_reservation", return_value=False
        ):
            with pytest.raises(AppException) as excinfo:
                await reservation_service.create_reservation(request, "user123")
            assert excinfo.value.code == ResponseCode.RESERVATION_PAST_TIME


@pytest.mark.asyncio
async def test_create_reservation_no_available_slots(reservation_service):
    request = CreateReservationRequest(
        lot_id="65e8a7b2c9e8a7b2c9e8a7b2",
        slot_id="auto",
        start_time=datetime.now(timezone.utc) + timedelta(hours=1),
        duration_minutes=60,
        payment_method="card",
        vehicle={"plate_number": "ABC-123", "type": "car"},
    )

    with patch.object(reservation_service, "find_available_slot", return_value=None):
        with pytest.raises(AppException) as excinfo:
            await reservation_service.create_reservation(request, "user123")
        assert excinfo.value.code == ResponseCode.RESERVATION_NO_AVAILABLE_SLOTS


@pytest.mark.asyncio
async def test_create_reservation_occupied_immediate(reservation_service):
    valid_id = "65e8a7b2c9e8a7b2c9e8a7b1"
    now = datetime.now(timezone.utc)
    request = CreateReservationRequest(
        lot_id="65e8a7b2c9e8a7b2c9e8a7b2",
        slot_id=valid_id,
        start_time=now,
        duration_minutes=60,
        payment_method="card",
        vehicle={"plate_number": "ABC-123", "type": "car"},
    )

    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_db.parking_slots.find_one = AsyncMock(
            return_value={
                "_id": ObjectId(valid_id),
                "lot_id": "65e8a7b2c9e8a7b2c9e8a7b2",
                "slot_number": "A1",
                "status": "occupied",
            }
        )

        with pytest.raises(AppException) as excinfo:
            await reservation_service.create_reservation(request, "user123")
        assert excinfo.value.code == ResponseCode.RESERVATION_SLOT_OCCUPIED


@pytest.mark.asyncio
async def test_create_reservation_occupied_future(reservation_service):
    valid_id = "65e8a7b2c9e8a7b2c9e8a7b1"
    future_time = datetime.now(timezone.utc) + timedelta(hours=2)
    request = CreateReservationRequest(
        lot_id="65e8a7b2c9e8a7b2c9e8a7b2",
        slot_id=valid_id,
        start_time=future_time,
        duration_minutes=60,
        payment_method="card",
        vehicle={"plate_number": "ABC-123", "type": "car"},
    )

    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_db.parking_slots.find_one = AsyncMock(
            return_value={
                "_id": ObjectId(valid_id),
                "lot_id": "65e8a7b2c9e8a7b2c9e8a7b2",
                "slot_number": "A1",
                "status": "occupied",
            }
        )
        mock_db.parking_lots.find_one = AsyncMock(
            return_value={
                "base_rate": 10.0,
                "_id": ObjectId("65e8a7b2c9e8a7b2c9e8a7b2"),
                "name": "Test Lot",
            }
        )
        mock_db.reservations.insert_one = AsyncMock(
            return_value=MagicMock(inserted_id=ObjectId())
        )

        with patch.object(
            reservation_service, "has_overlapping_reservation", return_value=False
        ):
            with patch(
                "app.services.notification_service.notification_service.send_notification",
                AsyncMock(),
            ):
                with patch(
                    "app.services.notification_service.notification_service.notify_admins",
                    AsyncMock(),
                ):
                    result = await reservation_service.create_reservation(
                        request, "user123"
                    )
                    assert result["status"] == "active"
                    assert result["slot_id"] == valid_id
