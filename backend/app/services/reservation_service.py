from datetime import datetime, timedelta, timezone
from typing import Any, List, Optional
import uuid
import json
from bson import ObjectId
from loguru import logger
from app.core.database import db
from app.core.redis import redis_cache
from app.schemas.reservation import CreateReservationRequest, ReservationResponse
from app.schemas.response import ResponseCode
from app.core.exceptions import AppException
from app.services.notification_service import notification_service


class ReservationService:
    async def has_overlapping_reservation(
        self, slot_id: str, start_time: datetime, end_time: datetime
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

    async def find_available_slot(
        self, lot_id: str, start_time: datetime, end_time: datetime
    ) -> Any:
        slots_cursor = db.client["parkflow"].parking_slots.find(
            {"lot_id": lot_id, "deleted_at": None}
        )
        slots = await slots_cursor.to_list(length=1000)

        for slot in slots:
            slot_id_str = str(slot["_id"])
            if not await self.has_overlapping_reservation(
                slot_id_str, start_time, end_time
            ):
                return slot

        return None

    async def create_reservation(
        self, request: CreateReservationRequest, user_id: str
    ) -> dict:
        if request.slot_id == "auto":
            if not request.lot_id:
                raise AppException(
                    message="lot_id is required for auto slot selection",
                    code=ResponseCode.RESERVATION_LOT_ID_REQUIRED,
                    status_code=400,
                )

            end_time = request.start_time + timedelta(minutes=request.duration_minutes)
            slot = await self.find_available_slot(
                request.lot_id, request.start_time, end_time
            )

            if not slot:
                raise AppException(
                    message="No available slots in this lot for the selected time window",
                    code=ResponseCode.RESERVATION_NO_AVAILABLE_SLOTS,
                    status_code=400,
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
                raise AppException(
                    message="Parking slot not found",
                    code=ResponseCode.RESERVATION_SLOT_NOT_FOUND,
                    status_code=404,
                )

            if slot.get("status") == "occupied":
                raise AppException(
                    message="Parking slot is already occupied",
                    code=ResponseCode.RESERVATION_SLOT_OCCUPIED,
                    status_code=400,
                )

        end_time = request.start_time + timedelta(minutes=request.duration_minutes)
        if await self.has_overlapping_reservation(
            request.slot_id, request.start_time, end_time
        ):
            raise AppException(
                message="This slot is already booked for the selected time window",
                code=ResponseCode.RESERVATION_SLOT_TIME_CONFLICT,
                status_code=400,
            )

        lot = await db.client["parkflow"].parking_lots.find_one(
            {"_id": ObjectId(slot["lot_id"])}
        )
        if not lot:
            raise AppException(
                message="Parking lot not found",
                code=ResponseCode.RESERVATION_LOT_NOT_FOUND,
                status_code=404,
            )

        price_per_hour = lot.get("base_rate", 0.0)
        total_price = (request.duration_minutes / 60.0) * price_per_hour

        now = datetime.now(timezone.utc)
        if request.start_time.tzinfo is None:
            request.start_time = request.start_time.replace(tzinfo=timezone.utc)

        start_time_utc = request.start_time

        if start_time_utc < now - timedelta(minutes=5):
            raise AppException(
                message="Reservation start time cannot be in the past",
                code=ResponseCode.RESERVATION_PAST_TIME,
                status_code=400,
            )

        qr_code = str(uuid.uuid4())
        end_time = request.start_time + timedelta(minutes=request.duration_minutes)
        if end_time.tzinfo is None:
            end_time = end_time.replace(tzinfo=timezone.utc)

        reservation_dict = {
            "user_id": user_id,
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
        reservation_dict["_id"] = result.inserted_id

        # Publish to Redis
        try:
            await redis_cache.client.publish(
                "reservation_updates",
                json.dumps({"user_id": user_id, "action": "created"}),
            )
        except Exception as e:
            logger.error(f"Failed to publish reservation update: {e}")

        await notification_service.send_notification(
            title="Reservation Created",
            message=f"Your booking for {lot.get('name')} has been confirmed.",
            user_id=user_id,
            notification_type="success",
            payload={"reservation_id": str(result.inserted_id), "action": "created"},
        )

        reservation_dict["lot_name"] = lot.get("name", "Unknown Lot")
        reservation_dict["lot_address"] = lot.get("address", "No Address")
        reservation_dict["lot_latitude"] = lot.get("latitude", 0.0)
        reservation_dict["lot_longitude"] = lot.get("longitude", 0.0)
        reservation_dict["slot_name"] = slot.get("slot_number", "Unknown Slot")

        return reservation_dict

    async def cancel_reservation(self, reservation_id: str, user_id: str) -> dict:
        reservation = await db.client["parkflow"].reservations.find_one(
            {"_id": ObjectId(reservation_id), "user_id": user_id, "deleted_at": None}
        )
        if not reservation:
            raise AppException(
                message="Reservation not found or already cancelled",
                code=ResponseCode.RESERVATION_NOT_FOUND,
                status_code=404,
            )

        if reservation.get("status") != "active":
            raise AppException(
                message=f"Only active reservations can be cancelled. Current status: {reservation.get('status')}",
                code=ResponseCode.ERROR,
                status_code=400,
            )

        await db.client["parkflow"].reservations.update_one(
            {"_id": ObjectId(reservation_id)},
            {"$set": {"status": "cancelled", "updated_at": datetime.now(timezone.utc)}},
        )

        await notification_service.send_notification(
            title="Reservation Cancelled",
            message="Your booking has been successfully cancelled.",
            user_id=user_id,
            notification_type="info",
            payload={"reservation_id": reservation_id, "action": "cancelled"},
        )

        try:
            await redis_cache.client.publish(
                "reservation_updates",
                json.dumps({"user_id": user_id, "action": "cancelled"}),
            )
        except Exception:
            pass

        return reservation


reservation_service = ReservationService()
