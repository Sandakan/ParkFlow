from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.reservation import CreateReservationRequest, ReservationResponse
from pydantic import BaseModel
from app.models.reservation import ReservationInDB
from app.core.database import db
from datetime import datetime, timedelta, timezone
import uuid
from bson import ObjectId

router = APIRouter()


class SlotAvailabilityResponse(BaseModel):
    available: bool
    slot_id: str | None = None


async def _has_overlapping_reservation(
    slot_id: str, start_time: datetime, end_time: datetime
) -> bool:
    # Overlap condition: (start1 < end2) AND (end1 > start2)
    count = await db.client["parkflow"].reservations.count_documents(
        {
            "slot_id": slot_id,
            "status": "active",
            "deleted_at": None,
            "$and": [
                {"start_time": {"$lt": end_time}},
                {"end_time": {"$gt": start_time}},
            ],
        }
    )
    return count > 0


async def _find_available_slot(
    lot_id: str, start_time: datetime, end_time: datetime
) -> Any:
    """
    Finds a slot in the given lot that has no overlapping reservations
    for the requested time window.
    """
    slots_cursor = db.client["parkflow"].parking_slots.find(
        {"lot_id": lot_id, "deleted_at": None}
    )
    slots = await slots_cursor.to_list(length=1000)

    for slot in slots:
        slot_id_str = str(slot["_id"])
        if not await _has_overlapping_reservation(slot_id_str, start_time, end_time):
            return slot

    return None


@router.post("/", response_model=APIResponse[ReservationResponse])
async def create_reservation(
    *,
    request: CreateReservationRequest,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Create a new reservation for a parking slot.
    """
    if request.slot_id == "auto":
        if not request.lot_id:
            return APIResponse.error_response(
                message="lot_id is required for auto slot selection",
                code=ResponseCode.RESERVATION_LOT_ID_REQUIRED,
                status_code=status.HTTP_400_BAD_REQUEST,
            )

        end_time = request.start_time + timedelta(minutes=request.duration_minutes)
        slot = await _find_available_slot(request.lot_id, request.start_time, end_time)

        if not slot:
            return APIResponse.error_response(
                message="No available slots in this lot for the selected time window",
                code=ResponseCode.RESERVATION_NO_AVAILABLE_SLOTS,
                status_code=status.HTTP_400_BAD_REQUEST,
            )
        request.slot_id = str(slot["_id"])
    else:
        try:
            slot = await db.client["parkflow"].parking_slots.find_one(
                {"_id": ObjectId(request.slot_id), "deleted_at": None}
            )
        except Exception:
            slot = None

        if not slot:
            return APIResponse.error_response(
                message="Parking slot not found",
                code=ResponseCode.RESERVATION_SLOT_NOT_FOUND,
                status_code=status.HTTP_404_NOT_FOUND,
            )

        if slot.get("status") == "occupied":
            return APIResponse.error_response(
                message="Parking slot is already occupied",
                code=ResponseCode.RESERVATION_SLOT_OCCUPIED,
                status_code=status.HTTP_400_BAD_REQUEST,
            )

    end_time = request.start_time + timedelta(minutes=request.duration_minutes)
    if await _has_overlapping_reservation(
        request.slot_id, request.start_time, end_time
    ):
        return APIResponse.error_response(
            message="This slot is already booked for the selected time window",
            code=ResponseCode.RESERVATION_SLOT_TIME_CONFLICT,
            status_code=status.HTTP_400_BAD_REQUEST,
        )

    lot = await db.client["parkflow"].parking_lots.find_one(
        {"_id": ObjectId(slot["lot_id"])}
    )
    if not lot:
        return APIResponse.error_response(
            message="Parking lot not found",
            code=ResponseCode.RESERVATION_LOT_NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND,
        )

    price_per_hour = lot.get("price_per_hour", 0.0)
    total_price = (request.duration_minutes / 60.0) * price_per_hour

    now = datetime.now(timezone.utc)
    qr_code = str(uuid.uuid4())
    end_time = request.start_time + timedelta(minutes=request.duration_minutes)

    reservation_dict = {
        "user_id": current_user.user_id,
        "slot_id": request.slot_id,
        "start_time": request.start_time,
        "end_time": end_time,
        "vehicle": request.vehicle.model_dump(),
        "duration_minutes": request.duration_minutes,
        "payment_method": request.payment_method,
        "total_price": total_price,
        "status": "active",
        "qr_code_token": qr_code,
        "created_at": now,
        "updated_at": now,
        "deleted_at": None,
    }

    result = await db.client["parkflow"].reservations.insert_one(reservation_dict)

    reservation_data = {
        "id": str(result.inserted_id),
        "user_id": current_user.user_id,
        "slot_id": request.slot_id,
        "start_time": request.start_time,
        "end_time": end_time,
        "vehicle": request.vehicle,
        "duration_minutes": request.duration_minutes,
        "payment_method": request.payment_method,
        "total_price": total_price,
        "status": "active",
        "qr_code_token": qr_code,
        "created_at": now,
        "updated_at": now,
    }

    return APIResponse.success_response(
        message="Reservation created successfully",
        code=ResponseCode.RESERVATION_CREATED,
        data=ReservationResponse(**reservation_data),
        status_code=201,
    )


@router.get("/me", response_model=APIResponse[List[ReservationResponse]])
async def get_my_reservations(
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Retrieve all active reservations for the current user.
    """
    cursor = (
        db.client["parkflow"]
        .reservations.find({"user_id": current_user.user_id, "deleted_at": None})
        .sort("created_at", -1)
    )

    reservations = await cursor.to_list(length=100)

    serialized = []
    for res in reservations:
        res_data = {
            "id": str(res["_id"]),
            "user_id": res["user_id"],
            "slot_id": res["slot_id"],
            "start_time": res["start_time"],
            "end_time": res["end_time"],
            "vehicle": res["vehicle"],
            "duration_minutes": res["duration_minutes"],
            "payment_method": res["payment_method"],
            "total_price": res["total_price"],
            "status": res["status"],
            "qr_code_token": res["qr_code_token"],
            "created_at": res["created_at"],
            "updated_at": res["updated_at"],
        }
        serialized.append(ReservationResponse(**res_data))

    return APIResponse.success_response(
        message="Reservations retrieved", code=ResponseCode.SUCCESS, data=serialized
    )


@router.get(
    "/slots/{slot_id}/availability",
    response_model=APIResponse[SlotAvailabilityResponse],
)
async def check_slot_availability(
    slot_id: str,
    start_time: datetime,
    duration_minutes: int,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Check if a specific slot is available for a given time window.
    """
    end_time = start_time + timedelta(minutes=duration_minutes)
    is_overlapping = await _has_overlapping_reservation(slot_id, start_time, end_time)

    return APIResponse.success_response(
        message="Availability checked",
        code=ResponseCode.SUCCESS,
        data=SlotAvailabilityResponse(
            available=not is_overlapping,
            slot_id=slot_id if not is_overlapping else None,
        ),
    )


@router.get(
    "/lots/{lot_id}/availability",
    response_model=APIResponse[SlotAvailabilityResponse],
)
async def check_lot_availability(
    lot_id: str,
    start_time: datetime,
    duration_minutes: int,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Check if any slot is available in the given lot for a given time window.
    """
    end_time = start_time + timedelta(minutes=duration_minutes)
    slot = await _find_available_slot(lot_id, start_time, end_time)

    return APIResponse.success_response(
        message="Lot availability checked",
        code=ResponseCode.SUCCESS,
        data=SlotAvailabilityResponse(
            available=slot is not None,
            slot_id=str(slot["_id"]) if slot else None,
        ),
    )
