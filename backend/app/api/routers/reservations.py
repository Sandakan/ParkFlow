from typing import Any, List, Optional
from fastapi import APIRouter, Depends, HTTPException, status, Request
from fastapi.encoders import jsonable_encoder
from sse_starlette.sse import EventSourceResponse
from app.api.deps import get_current_user, get_current_admin
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.reservation import CreateReservationRequest, ReservationResponse
from pydantic import BaseModel
from app.models.reservation import ReservationInDB
from app.core.database import db
from app.core.redis import redis_cache
from datetime import datetime, timedelta, timezone
import uuid
import json
import asyncio
from bson import ObjectId
from app.services.notification_service import notification_service
from loguru import logger

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

    price_per_hour = lot.get("base_rate", 0.0)
    total_price = (request.duration_minutes / 60.0) * price_per_hour

    now = datetime.now(timezone.utc)
    if request.start_time.tzinfo is None:
        request.start_time = request.start_time.replace(tzinfo=timezone.utc)

    start_time_utc = request.start_time

    logger.debug(f"Creating Reservation - RAW start_time: {request.start_time}")
    logger.debug(f"Creating Reservation - UTC start_time: {start_time_utc}")
    logger.debug(f"Creating Reservation - NOW (UTC): {now}")

    if start_time_utc < now - timedelta(minutes=5):
        logger.debug("Reservation creation failed: past time")
        return APIResponse.error_response(
            message="Reservation start time cannot be in the past",
            code=ResponseCode.RESERVATION_PAST_TIME,
            status_code=status.HTTP_400_BAD_REQUEST,
        )

    qr_code = str(uuid.uuid4())
    end_time = request.start_time + timedelta(minutes=request.duration_minutes)
    if end_time.tzinfo is None:
        end_time = end_time.replace(tzinfo=timezone.utc)

    reservation_dict = {
        "user_id": current_user.user_id,
        "slot_id": request.slot_id,
        "start_time": request.start_time,
        "end_time": end_time,
        "vehicle": request.vehicle.model_dump(),
        "duration_minutes": request.duration_minutes,
        "payment_method": request.payment_method,
        "total_price": total_price,
        "base_rate": price_per_hour,
        "actual_end_time": end_time,
        "total_billed_price": total_price,
        "check_in_time": None,
        "check_out_time": None,
        "status": "active",
        "qr_code_token": qr_code,
        "created_at": now,
        "updated_at": now,
        "deleted_at": None,
    }

    result = await db.client["parkflow"].reservations.insert_one(reservation_dict)

    try:
        await redis_cache.client.publish(
            "reservation_updates",
            json.dumps({"user_id": current_user.user_id, "action": "created"}),
        )
    except Exception as e:
        logger.error(f"Failed to publish reservation update: {e}")

    await notification_service.send_notification(
        title="Reservation Created",
        message=f"Your booking for {lot.get('name')} has been confirmed.",
        user_id=current_user.user_id,
        notification_type="success",
        payload={"reservation_id": str(result.inserted_id), "action": "created"},
    )

    await notification_service.send_notification(
        title="Reservation Created",
        message=f"Your booking for {lot.get('name')} has been confirmed.",
        user_id=current_user.user_id,
        notification_type="success",
        payload={"reservation_id": str(result.inserted_id), "action": "created"},
    )

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
        "base_rate": price_per_hour,
        "actual_end_time": end_time,
        "total_billed_price": total_price,
        "status": "active",
        "qr_code_token": qr_code,
        "lot_name": lot.get("name", "Unknown Lot"),
        "lot_address": lot.get("address", "No Address"),
        "lot_latitude": lot.get("latitude", 0.0),
        "lot_longitude": lot.get("longitude", 0.0),
        "slot_name": slot.get("slot_number", "Unknown Slot"),
        "created_at": now,
        "updated_at": now,
    }

    return APIResponse.success_response(
        message="Reservation created successfully",
        code=ResponseCode.RESERVATION_CREATED,
        data=ReservationResponse(**reservation_data),
        status_code=201,
    )


@router.post("/scan/{token}", response_model=APIResponse[ReservationResponse])
async def scan_reservation_qr(
    token: str,
    confirm: bool = False,
    payment_method: Optional[str] = None,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Scan a reservation QR code to log check-in or check-out.
    Only accessible by administrators (operators).

    If confirm is False, it only retrieves the reservation details without processing.
    """
    now = datetime.now(timezone.utc)
    reservation = await db.client["parkflow"].reservations.find_one(
        {"qr_code_token": token, "deleted_at": None}
    )

    if not reservation:
        return APIResponse.error_response(
            message="Reservation not found",
            code=ResponseCode.RESERVATION_NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND,
        )

    res_id = reservation["_id"]
    status_val = reservation.get("status")

    if status_val == "completed":
        return APIResponse.error_response(
            message="Reservation is already completed",
            code=ResponseCode.ERROR,
            status_code=status.HTTP_400_BAD_REQUEST,
        )

    if status_val == "cancelled":
        return APIResponse.error_response(
            message="Reservation has been cancelled",
            code=ResponseCode.ERROR,
            status_code=status.HTTP_400_BAD_REQUEST,
        )

    res_data = {
        "id": str(reservation["_id"]),
        "user_id": reservation["user_id"],
        "slot_id": reservation["slot_id"],
        "start_time": reservation["start_time"],
        "end_time": reservation["end_time"],
        "vehicle": reservation["vehicle"],
        "duration_minutes": reservation["duration_minutes"],
        "payment_method": reservation["payment_method"],
        "total_price": reservation["total_price"],
        "base_rate": reservation.get("base_rate", 0.0),
        "check_in_time": reservation.get("check_in_time"),
        "check_out_time": reservation.get("check_out_time"),
        "actual_end_time": reservation.get("actual_end_time", reservation["end_time"]),
        "total_billed_price": reservation.get(
            "total_billed_price", reservation["total_price"]
        ),
        "status": reservation.get("status", "active"),
        "qr_code_token": reservation["qr_code_token"],
        "lot_name": "Unknown Lot",
        "lot_address": "No Address",
        "lot_latitude": 0.0,
        "lot_longitude": 0.0,
        "slot_name": "Unknown Slot",
        "created_at": reservation["created_at"],
        "updated_at": reservation["updated_at"],
    }

    res_slot = await db.client["parkflow"].parking_slots.find_one(
        {"_id": ObjectId(reservation["slot_id"])}
    )
    if res_slot:
        res_data["slot_name"] = res_slot.get("slot_number", "Unknown Slot")
        res_lot = await db.client["parkflow"].parking_lots.find_one(
            {"_id": ObjectId(res_slot["lot_id"])}
        )
        if res_lot:
            res_data["lot_name"] = res_lot.get("name", "Unknown Lot")
            res_data["lot_address"] = res_lot.get("address", "No Address")
            res_data["lot_latitude"] = res_lot.get("latitude", 0.0)
            res_data["lot_longitude"] = res_lot.get("longitude", 0.0)
            if not res_data.get("base_rate"):
                res_data["base_rate"] = res_lot.get("base_rate", 0.0)

    if not confirm:
        if (
            reservation.get("check_in_time") is not None
            and reservation.get("check_out_time") is None
        ):
            check_in_time = reservation["check_in_time"]
            if check_in_time.tzinfo is None:
                check_in_time = check_in_time.replace(tzinfo=timezone.utc)

            duration_seconds = (now - check_in_time).total_seconds()
            duration_hours = max(0, duration_seconds / 3600.0)

            base_rate = res_data.get("base_rate", 0.0)
            original_total = res_data.get("total_price", 0.0)
            actual_stay_price = round(duration_hours * base_rate, 2)

            res_data["total_billed_price"] = max(original_total, actual_stay_price)
            res_data["check_out_time"] = now
            res_data["status"] = "completed"

        return APIResponse.success_response(
            message="Reservation details retrieved",
            code=ResponseCode.SUCCESS,
            data=ReservationResponse(**res_data),
        )

    update_data = {"updated_at": now}
    message = ""

    # Check-in logic
    if reservation.get("check_in_time") is None:
        start_time = reservation["start_time"]
        if start_time.tzinfo is None:
            start_time = start_time.replace(tzinfo=timezone.utc)

        end_time = reservation["end_time"]
        if end_time.tzinfo is None:
            end_time = end_time.replace(tzinfo=timezone.utc)

        logger.debug("Scanning Reservation QR for Check-in")

        if now < start_time - timedelta(minutes=15):
            return APIResponse.error_response(
                message="Too early for check-in. Please wait until 15 minutes before your scheduled time.",
                code=ResponseCode.ERROR,
                status_code=status.HTTP_400_BAD_REQUEST,
            )

        if now > end_time:
            return APIResponse.error_response(
                message="Reservation has already expired.",
                code=ResponseCode.ERROR,
                status_code=status.HTTP_400_BAD_REQUEST,
            )

        update_data["check_in_time"] = now
        res_data["check_in_time"] = now
        message = "Checked in successfully"

        await notification_service.send_notification(
            title="Checked In",
            message=f"You have successfully checked in at {res_data['lot_name']}.",
            user_id=reservation["user_id"],
            notification_type="info",
            payload={"reservation_id": str(res_id), "action": "check_in"},
        )

    elif reservation.get("check_out_time") is None:
        check_in_time = reservation["check_in_time"].replace(tzinfo=timezone.utc)
        update_data["check_out_time"] = now
        update_data["actual_end_time"] = now
        update_data["status"] = "completed"

        if payment_method:
            update_data["payment_method"] = payment_method
            res_data["payment_method"] = payment_method

        duration_seconds = (now - check_in_time).total_seconds()
        duration_hours = duration_seconds / 3600.0

        base_rate = reservation.get("base_rate", 0.0)
        original_total = reservation.get("total_price", 0.0)
        actual_stay_price = round(duration_hours * base_rate, 2)

        # Pay full amount if early, but calculate based on stay if overstay
        total_billed = max(original_total, actual_stay_price)

        update_data["total_billed_price"] = total_billed

        res_data["check_out_time"] = now
        res_data["actual_end_time"] = now
        res_data["status"] = "completed"
        res_data["total_billed_price"] = total_billed

        message = "Checked out successfully"

        await notification_service.send_notification(
            title="Checked Out",
            message=f"You have checked out from {res_data['lot_name']}. Total: LKR {total_billed}",
            user_id=reservation["user_id"],
            notification_type="success",
            payload={"reservation_id": str(res_id), "action": "check_out"},
        )
    else:
        return APIResponse.error_response(
            message="Reservation already processed",
            code=ResponseCode.ERROR,
            status_code=status.HTTP_400_BAD_REQUEST,
        )

    await db.client["parkflow"].reservations.update_one(
        {"_id": res_id}, {"$set": update_data}
    )

    # Notify subscribers
    try:
        await redis_cache.client.publish(
            "reservation_updates",
            json.dumps(
                {
                    "user_id": reservation["user_id"],
                    "reservation_id": str(res_id),
                    "action": "status_change",
                    "status": update_data.get("status", reservation.get("status")),
                }
            ),
        )
    except Exception as e:
        logger.error(f"Failed to publish reservation update: {e}")

    return APIResponse.success_response(
        message=message,
        code=ResponseCode.SUCCESS,
        data=ReservationResponse(**res_data),
    )

    return APIResponse.success_response(
        message=message,
        code=ResponseCode.SUCCESS,
        data=ReservationResponse(**res_data),
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
            "base_rate": res.get("base_rate", 0.0),
            "check_in_time": res.get("check_in_time"),
            "check_out_time": res.get("check_out_time"),
            "actual_end_time": res.get("actual_end_time", res["end_time"]),
            "total_billed_price": res.get("total_billed_price", res["total_price"]),
            "status": res.get("status", "active"),
            "qr_code_token": res["qr_code_token"],
            "lot_name": "Unknown Lot",
            "lot_address": "No Address",
            "lot_latitude": 0.0,
            "lot_longitude": 0.0,
            "slot_name": "Unknown Slot",
            "created_at": res["created_at"],
            "updated_at": res["updated_at"],
        }

        res_slot = await db.client["parkflow"].parking_slots.find_one(
            {"_id": ObjectId(res["slot_id"])}
        )
        if res_slot:
            res_data["slot_name"] = res_slot.get("slot_number", "Unknown Slot")
            res_lot = await db.client["parkflow"].parking_lots.find_one(
                {"_id": ObjectId(res_slot["lot_id"])}
            )
            if res_lot:
                res_data["lot_name"] = res_lot.get("name", "Unknown Lot")
                res_data["lot_address"] = res_lot.get("address", "No Address")
                res_data["lot_latitude"] = res_lot.get("latitude", 0.0)
                res_data["lot_longitude"] = res_lot.get("longitude", 0.0)
                if not res_data.get("base_rate"):
                    res_data["base_rate"] = res_lot.get("base_rate", 0.0)
                    res_data["total_price"] = (
                        res_data["duration_minutes"] / 60.0
                    ) * res_data["base_rate"]
                    res_data["total_billed_price"] = res_data["total_price"]

            if res_data.get("check_in_time") and not res_data.get("check_out_time"):
                now = datetime.now(timezone.utc)
                check_in_time = res_data["check_in_time"]
                if check_in_time.tzinfo is None:
                    check_in_time = check_in_time.replace(tzinfo=timezone.utc)

                duration_seconds = (now - check_in_time).total_seconds()
                duration_hours = max(0, duration_seconds / 3600.0)
                live_price = round(duration_hours * res_data["base_rate"], 2)
                res_data["total_billed_price"] = max(
                    res_data["total_price"], live_price
                )

        serialized.append(ReservationResponse(**res_data))

    return APIResponse.success_response(
        message="Reservations retrieved", code=ResponseCode.SUCCESS, data=serialized
    )


@router.get(
    "/stream",
    summary="SSE stream for real-time reservation updates",
    description="Streams the user's reservations whenever a status change or new reservation occurs.",
)
async def reservations_stream(
    request: Request,
    current_user: Any = Depends(get_current_user),
):
    async def event_generator():
        pubsub = redis_cache.client.pubsub()
        await pubsub.subscribe("reservation_updates")

        try:
            initial_res = await get_my_reservations(current_user=current_user)
            if initial_res.data:
                yield {"data": json.dumps(jsonable_encoder(initial_res.data))}
            else:
                yield {"data": json.dumps([])}

            while True:
                if await request.is_disconnected():
                    logger.info(f"SSE: User {current_user.user_id} disconnected")
                    break

                message = await pubsub.get_message(
                    ignore_subscribe_messages=True, timeout=1.0
                )
                if message:
                    try:
                        data = json.loads(message["data"])
                        # Only notify if it belongs to the current user
                        if data.get("user_id") == current_user.user_id:
                            updated_res = await get_my_reservations(
                                current_user=current_user
                            )
                            yield {
                                "data": json.dumps(jsonable_encoder(updated_res.data))
                            }
                    except Exception as e:
                        logger.error(f"SSE: Error processing message: {e}")

                await asyncio.sleep(0.1)
        except Exception as e:
            logger.error(f"SSE: Stream error for user {current_user.user_id}: {e}")
        finally:
            await pubsub.unsubscribe("reservation_updates")
            await pubsub.close()

    return EventSourceResponse(event_generator())


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
