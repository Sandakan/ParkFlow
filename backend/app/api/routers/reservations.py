from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.reservation import CreateReservationRequest, ReservationResponse
from app.models.reservation import ReservationInDB
from app.core.database import db
from datetime import datetime, timedelta, timezone
import uuid
from bson import ObjectId

router = APIRouter()


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
            raise HTTPException(
                status_code=400, detail="lot_id is required for auto slot selection"
            )

        slot = await db.client["parkflow"].parking_slots.find_one(
            {"lot_id": request.lot_id, "status": "available", "deleted_at": None}
        )
        if not slot:
            raise HTTPException(
                status_code=400, detail="No available slots in this lot"
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
            raise HTTPException(status_code=404, detail="Parking slot not found")

        if slot.get("status") == "occupied":
            raise HTTPException(
                status_code=400, detail="Parking slot is already occupied"
            )

    lot = await db.client["parkflow"].parking_lots.find_one(
        {"_id": ObjectId(slot["lot_id"])}
    )
    if not lot:
        raise HTTPException(status_code=404, detail="Parking lot not found")

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
        code=ResponseCode.SUCCESS,
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
