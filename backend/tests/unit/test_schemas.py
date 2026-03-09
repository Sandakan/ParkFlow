import pytest
from datetime import datetime, timedelta, timezone
from pydantic import ValidationError
from app.schemas.reservation import CreateReservationRequest


def test_create_reservation_request_valid():
    # Test valid reservation request
    start_time = datetime.now(timezone.utc) + timedelta(hours=1)
    data = {
        "lot_id": "65e8a7b2c9e8a7b2c9e8a7b2",
        "slot_id": "auto",
        "start_time": start_time,
        "duration_minutes": 60,
        "payment_method": "card",
        "vehicle": {"plate_number": "ABC-1234", "type": "car"},
    }
    request = CreateReservationRequest(**data)
    assert request.duration_minutes == 60
    assert request.slot_id == "auto"


def test_create_reservation_request_invalid_duration():
    start_time = datetime.now(timezone.utc) + timedelta(hours=1)
    data = {
        "lot_id": "65e8a7b2c9e8a7b2c9e8a7b2",
        "slot_id": "auto",
        "start_time": start_time,
        "duration_minutes": -10,
        "payment_method": "card",
        "vehicle": {"plate_number": "ABC-1234", "type": "car"},
    }
    pass


def test_create_reservation_request_missing_fields():
    data = {
        "slot_id": "auto",
    }
    with pytest.raises(ValidationError):
        CreateReservationRequest(**data)
