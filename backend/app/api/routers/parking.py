from typing import Any, List, Optional
from fastapi import APIRouter, Depends, Query, status
from app.api.deps import get_current_user, get_current_admin
from app.schemas.response import APIResponse, ResponseCode
from app.models.parking_slot import ParkingSlotInDB
from app.models.parking_lot import ParkingLotInDB, Point
from app.schemas.parking import CreateParkingLotRequest, UpdateParkingLotRequest, CreateCameraRequest, CreateParkingSlotRequest, UpdateParkingSlotRequest
from app.schemas.reservation import CreateReservationRequest, ReservationResponse
from app.core.database import db

router = APIRouter()


async def _update_logical_slot_status(slot_id: str):
    """
    Recalculate the logical slot status based on the Boolean OR of all its active mappings.
    If ANY mapping is occupied, the logical slot is occupied.
    """
    from datetime import datetime, timezone
    from bson import ObjectId
    
    # 1. Fetch all active mappings for this logical slot
    cursor = db.client["parkflow"].camera_slot_mappings.find({
        "slot_id": slot_id,
        "deleted_at": None
    })
    mappings = await cursor.to_list(length=100)
    
    # 2. Boolean OR logic: Any mapping is_occupied=True means logical slot is occupied
    is_any_occupied = any(m.get("is_occupied", False) for m in mappings)
    
    # 3. Update logical slot status
    new_status = "occupied" if is_any_occupied else "vacant"
    
    # Fetch current logical slot to check if change is needed (and respect "reserved")
    slot = await db.client["parkflow"].parking_slots.find_one({"_id": ObjectId(slot_id)})
    if slot and slot.get("status") != "reserved":
        if slot.get("status") != new_status:
            await db.client["parkflow"].parking_slots.update_one(
                {"_id": ObjectId(slot_id)},
                {"$set": {
                    "status": new_status,
                    "updated_at": datetime.now(timezone.utc)
                }}
            )


@router.get(
    "/slots",
    response_model=APIResponse[dict],
    description="Retrieve the list of all parking slots and their current occupancy status.",
)
async def get_parking_slots(
    camera_id: Optional[str] = Query(None, description="Filter slots by camera ID"),
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get all parking slots.
    """
    if camera_id:
        # Fetch mappings for this camera
        cursor = db.client["parkflow"].camera_slot_mappings.find({"camera_id": camera_id, "deleted_at": None})
        mappings = await cursor.to_list(length=1000)
        
        serialized_slots = []
        for m in mappings:
            # Fetch logical slot info
            from bson import ObjectId
            slot = await db.client["parkflow"].parking_slots.find_one({"_id": ObjectId(m["slot_id"])})
            if slot:
                serialized_slots.append({
                    "id": str(slot["_id"]),
                    "name": slot.get("slot_number", "Unnamed"),
                    "isOccupied": slot.get("status") == "occupied",
                    "camera_id": camera_id,
                    "coordinates": m.get("coordinates", []),
                    "lastUpdated": slot.get("updated_at").isoformat() if slot.get("updated_at") else None
                })
    else:
        # Fetch all logical slots
        query = {"deleted_at": None}
        cursor = db.client["parkflow"].parking_slots.find(query)
        slots = await cursor.to_list(length=1000)
        
        serialized_slots = []
        for slot in slots:
            serialized_slots.append({
                "id": str(slot.get("_id") or slot.get("parking_slot_id")),
                "name": slot.get("slot_number", "Unnamed"),
                "isOccupied": slot.get("status") == "occupied",
                "lastUpdated": slot.get("updated_at").isoformat() if slot.get("updated_at") else None
            })

    return APIResponse.success_response(
        message="Parking slots retrieved",
        code=ResponseCode.SUCCESS,
        data={"slots": serialized_slots},
    )

@router.post(
    "/lots",
    response_model=APIResponse[dict],
    description="Create a new parking lot.",
    status_code=status.HTTP_201_CREATED,
)
async def create_parking_lot(
    request: CreateParkingLotRequest,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Create a new parking lot.
    """

    from pprint import pprint
    from bson import ObjectId

    # Generating basic metadata structure similar to what get_lots randomly creates
    metrics = {
        "cameras": 1, 
        "occupancy": 0.0,
        "revenue_today": 0
    }

    from datetime import datetime, timezone
    now = datetime.now(timezone.utc)
    new_lot = {
        "name": request.name,
        "address": request.address,
        "location": {"type": "Point", "coordinates": [request.longitude, request.latitude]},
        "total_slots": request.total_slots,
        "status": "open",
        "price_per_hour": request.price_per_hour,
        "metrics": metrics,
        "created_at": now,
        "updated_at": now,
        
        "deleted_at": None,
    }
    
    result = await db.client["parkflow"].parking_lots.insert_one(new_lot)

    return APIResponse.success_response(
        message="Parking lot created successfully",
        code=ResponseCode.SUCCESS,
        data={"id": str(result.inserted_id)},
        status_code=status.HTTP_201_CREATED
    )


@router.get(
    "/lots",
    response_model=APIResponse[dict],
    description="Retrieve the list of parking lots optionally filtered by search query.",
)
async def get_parking_lots(
    search: Optional[str] = Query(None, description="Search term for parking lot name"),
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get all parking lots.
    """
    query = {"deleted_at": None}
    if search:
        query["name"] = {"$regex": search, "$options": "i"}

    cursor = db.client["parkflow"].parking_lots.find(query)
    lots = await cursor.to_list(length=1000)
    
    serialized_lots = []
    import random
    
    for lot in lots:
        is_open = random.choice([True, False]) if "status" not in lot else lot.get("status") == "open"
        metrics = lot.get("metrics", {})
        cameras_count = metrics.get("cameras", random.randint(1, 10))
        occupancy = metrics.get("occupancy", random.uniform(0.1, 0.95))
        revenue_today = metrics.get("revenue_today", random.randint(100, 10000))
        address = lot.get("address", "Unknown Address")
        
        serialized_lots.append({
            "id": str(lot.get("_id") or lot.get("parking_lot_id")),
            "name": lot.get("name", "Unnamed Lot"),
            "isOpen": is_open,
            "camerasCount": cameras_count,
            "totalSlots": lot.get("total_slots", 0),
            "occupancy": occupancy,
            "revenueToday": revenue_today,
            "address": address,
        })

    return APIResponse.success_response(
        message="Parking lots retrieved",
        code=ResponseCode.SUCCESS,
        data={"lots": serialized_lots},
    )


@router.get(
    "/lots/{lot_id}",
    response_model=APIResponse[dict],
    description="Retrieve a specific parking lot by ID.",
)
async def get_parking_lot(
    lot_id: str,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get a single parking lot.
    """
    from bson import ObjectId
    
    try:
        lot = await db.client["parkflow"].parking_lots.find_one({"_id": ObjectId(lot_id), "deleted_at": None})
    except Exception:
        lot = None
        
    if not lot:
        return APIResponse.error_response(
            message="Parking lot not found",
            code=ResponseCode.NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND
        )

    return APIResponse.success_response(
        message="Parking lot retrieved",
        code=ResponseCode.SUCCESS,
        data={
            "id": str(lot.get("_id")),
            "name": lot.get("name"),
            "address": lot.get("address"),
            "latitude": lot.get("location", {}).get("coordinates", [0, 0])[1],
            "longitude": lot.get("location", {}).get("coordinates", [0, 0])[0],
            "totalSlots": lot.get("total_slots", 0),
        },
    )


@router.put(
    "/lots/{lot_id}",
    response_model=APIResponse[dict],
    description="Update a specific parking lot by ID.",
)
async def update_parking_lot(
    lot_id: str,
    request: UpdateParkingLotRequest,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Update a parking lot.
    """
    from bson import ObjectId
    
    update_data = {}
    if request.name is not None:
        update_data["name"] = request.name
    if request.address is not None:
        update_data["address"] = request.address
    if request.latitude is not None or request.longitude is not None:
        # Get existing coordinates if only one is provided
        existing = await db.client["parkflow"].parking_lots.find_one({"_id": ObjectId(lot_id)})
        if existing:
            coords = existing.get("location", {}).get("coordinates", [0, 0])
            lon = request.longitude if request.longitude is not None else coords[0]
            lat = request.latitude if request.latitude is not None else coords[1]
            update_data["location"] = {"type": "Point", "coordinates": [lon, lat]}
            
    if request.total_slots is not None:
        update_data["total_slots"] = request.total_slots
    if request.price_per_hour is not None:
        update_data["price_per_hour"] = request.price_per_hour

    if not update_data:
        return APIResponse.success_response(message="No changes specify", data={})
    
    from datetime import datetime, timezone
    update_data["updated_at"] = datetime.now(timezone.utc)

    result = await db.client["parkflow"].parking_lots.update_one(
        {"_id": ObjectId(lot_id), "deleted_at": None},
        {"$set": update_data}
    )

    if result.matched_count == 0:
        return APIResponse.error_response(
            message="Parking lot not found",
            code=ResponseCode.NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND
        )

    return APIResponse.success_response(
        message="Parking lot updated successfully",
        code=ResponseCode.SUCCESS,
    )


@router.delete(
    "/lots/{lot_id}",
    response_model=APIResponse[dict],
    description="Delete a specific parking lot by ID.",
)
async def delete_parking_lot(
    lot_id: str,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Delete a parking lot.
    """
    from bson import ObjectId
    
    from datetime import datetime, timezone
    
    result = await db.client["parkflow"].parking_lots.update_one(
        {"_id": ObjectId(lot_id), "deleted_at": None},
        {
            "$set": {
                "deleted_at": datetime.now(timezone.utc)
            }
        }
    )

    if result.matched_count == 0:
        return APIResponse.error_response(
            message="Parking lot not found",
            code=ResponseCode.NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND
        )

    return APIResponse.success_response(
        message="Parking lot deleted successfully",
        code=ResponseCode.SUCCESS,
    )

@router.post(
    "/slots",
    response_model=APIResponse[dict],
    description="Add a new parking slot to a lot.",
    status_code=status.HTTP_201_CREATED,
)
async def create_parking_slot(
    request: CreateParkingSlotRequest,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Create a new parking slot with mapping.
    """
    from datetime import datetime, timezone
    from bson import ObjectId
    now = datetime.now(timezone.utc)
    
    # 1. Find or Create logical slot
    slot_filter = {
        "lot_id": request.lot_id,
        "slot_number": request.slot_number,
        "deleted_at": None
    }
    
    existing_slot = await db.client["parkflow"].parking_slots.find_one(slot_filter)
    
    if existing_slot:
        slot_id = existing_slot["_id"]
    else:
        new_slot = {
            "lot_id": request.lot_id,
            "slot_number": request.slot_number,
            "status": "vacant",
            "slot_type": request.slot_type,
            "created_at": now,
            "updated_at": now,
            "deleted_at": None,
        }
        result = await db.client["parkflow"].parking_slots.insert_one(new_slot)
        slot_id = result.inserted_id

    # 2. Upsert Camera Slot Mapping
    mapping_filter = {
        "camera_id": request.camera_id,
        "slot_id": str(slot_id),
        "deleted_at": None
    }
    
    mapping_data = {
        "camera_id": request.camera_id,
        "slot_id": str(slot_id),
        "coordinates": [c.model_dump() for c in request.coordinates],
        "is_occupied": False, # Initial state
        "updated_at": now
    }
    
    await db.client["parkflow"].camera_slot_mappings.update_one(
        mapping_filter,
        {
            "$set": mapping_data,
            "$setOnInsert": {"created_at": now}
        },
        upsert=True
    )

    return APIResponse.success_response(
        message="Parking slot mapping created successfully",
        code=ResponseCode.SUCCESS,
        data={"id": str(slot_id)},
        status_code=status.HTTP_201_CREATED
    )


@router.put(
    "/slots/{slot_id}",
    response_model=APIResponse[dict],
    description="Update a parking slot or its mapping.",
)
async def update_parking_slot(
    slot_id: str,
    request: UpdateParkingSlotRequest,
    camera_id: Optional[str] = Query(None, description="Camera ID if updating a specific mapping"),
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Update a parking slot or its mapping coordinates.
    """
    from datetime import datetime, timezone
    from bson import ObjectId
    now = datetime.now(timezone.utc)
    
    if camera_id and request.coordinates is not None:
        # Update specific mapping coordinates
        await db.client["parkflow"].camera_slot_mappings.update_one(
            {"camera_id": camera_id, "slot_id": slot_id, "deleted_at": None},
            {"$set": {
                "coordinates": [c.model_dump() for c in request.coordinates],
                "updated_at": now
            }}
        )
    
    # Update logical slot details (name, etc)
    update_data = {}
    if request.slot_number is not None:
        update_data["slot_number"] = request.slot_number
    if request.slot_type is not None:
        update_data["slot_type"] = request.slot_type
    
    if update_data:
        update_data["updated_at"] = now
        await db.client["parkflow"].parking_slots.update_one(
            {"_id": ObjectId(slot_id), "deleted_at": None},
            {"$set": update_data}
        )

    return APIResponse.success_response(
        message="Parking slot updated successfully",
        code=ResponseCode.SUCCESS,
    )


@router.delete(
    "/slots/{slot_id}",
    response_model=APIResponse[dict],
    description="Delete a parking slot or a specific camera mapping.",
)
async def delete_parking_slot(
    slot_id: str,
    camera_id: Optional[str] = Query(None, description="Camera ID if deleting a specific mapping"),
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Delete a parking slot mapping or the logical slot itself.
    """
    from datetime import datetime, timezone
    from bson import ObjectId
    now = datetime.now(timezone.utc)
    
    if camera_id:
        # Delete only the specific mapping
        result = await db.client["parkflow"].camera_slot_mappings.update_one(
            {"camera_id": camera_id, "slot_id": slot_id, "deleted_at": None},
            {"$set": {"deleted_at": now}}
        )
        # Recalculate logical status since a sensor input was removed
        await _update_logical_slot_status(slot_id)
    else:
        # Delete logical slot and ALL its mappings
        await db.client["parkflow"].parking_slots.update_one(
            {"_id": ObjectId(slot_id), "deleted_at": None},
            {"$set": {"deleted_at": now}}
        )
        await db.client["parkflow"].camera_slot_mappings.update_many(
            {"slot_id": slot_id, "deleted_at": None},
            {"$set": {"deleted_at": now}}
        )
        result = type('obj', (object,), {'matched_count': 1}) # Mock result

    return APIResponse.success_response(
        message="Parking slot/mapping deleted successfully",
        code=ResponseCode.SUCCESS,
    )


@router.post(
    "/slots/{slot_id}/test-detection",
    response_model=APIResponse[dict],
    description="Mock endpoint to test Boolean OR sensor fusion logic.",
)
async def test_detection(
    slot_id: str,
    camera_id: str = Query(..., description="Camera ID reporting the detection"),
    is_occupied: bool = Query(..., description="Detection result from this camera"),
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Update a mapping's detection state and trigger Sensor Fusion.
    """
    from datetime import datetime, timezone
    now = datetime.now(timezone.utc)
    
    await db.client["parkflow"].camera_slot_mappings.update_one(
        {"camera_id": camera_id, "slot_id": slot_id},
        {"$set": {
            "is_occupied": is_occupied,
            "updated_at": now
        }}
    )
    
    await _update_logical_slot_status(slot_id)
    
    # Fetch final logical status
    from bson import ObjectId
    slot = await db.client["parkflow"].parking_slots.find_one({"_id": ObjectId(slot_id)})
    
    return APIResponse.success_response(
        message="Detection processed and fusion recalculated",
        data={
            "logical_slot_id": slot_id,
            "new_logical_status": slot.get("status") if slot else "unknown"
        }
    )


@router.post(
    "/reservations",
    response_model=APIResponse[dict],
    description="Create a new reservation.",
    status_code=status.HTTP_201_CREATED,
)
async def create_reservation(
    request: CreateReservationRequest,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Create a new reservation.
    """
    from datetime import datetime, timezone
    import uuid
    now = datetime.now(timezone.utc)
    
    # Simple QR code generation for demonstration
    qr_code = str(uuid.uuid4())
    
    new_reservation = {
        "user_id": request.user_id,
        "slot_id": request.slot_id,
        "start_time": request.start_time,
        "end_time": request.end_time,
        "status": "active",
        "qr_code_token": qr_code,
        "created_at": now,
        "updated_at": now,
        
        "deleted_at": None,
    }
    
    result = await db.client["parkflow"].reservations.insert_one(new_reservation)

    return APIResponse.success_response(
        message="Reservation created successfully",
        code=ResponseCode.SUCCESS,
        data={"id": str(result.inserted_id), "qrCode": qr_code},
        status_code=status.HTTP_201_CREATED
    )


@router.get(
    "/reservations",
    response_model=APIResponse[dict],
    description="Retrieve the list of reservations for the current user.",
)
async def get_reservations(
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get all reservations for current user.
    """
    # Assuming user_id is accessible from current_user
    user_id = str(getattr(current_user, "user_id", current_user.get("_id") if isinstance(current_user, dict) else None))
    
    query = {"deleted_at": None}
    if current_user.role != "admin":
        query["user_id"] = user_id

    cursor = db.client["parkflow"].reservations.find(query)
    reservations = await cursor.to_list(length=100)
    
    serialized_reservations = []
    for res in reservations:
        serialized_reservations.append({
            "id": str(res.get("_id")),
            "userId": res.get("user_id"),
            "slotId": res.get("slot_id"),
            "startTime": res.get("start_time").isoformat() if res.get("start_time") else None,
            "endTime": res.get("end_time").isoformat() if res.get("end_time") else None,
            "status": res.get("status"),
            "createdAt": res.get("created_at").isoformat() if res.get("created_at") else None,
            "updatedAt": res.get("updated_at").isoformat() if res.get("updated_at") else None,
        })

    return APIResponse.success_response(
        message="Reservations retrieved",
        code=ResponseCode.SUCCESS,
        data={"reservations": serialized_reservations},
    )
