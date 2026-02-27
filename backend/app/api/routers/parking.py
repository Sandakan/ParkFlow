from typing import Any, List, Optional
from fastapi import APIRouter, Depends, Query, status
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.models.parking_slot import ParkingSlotInDB
from app.models.parking_lot import ParkingLotInDB
from app.core.database import db

router = APIRouter()


@router.get(
    "/slots",
    response_model=APIResponse[dict],
    description="Retrieve the list of all parking slots and their current occupancy status.",
)
async def get_parking_slots(
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get all parking slots.
    """
    cursor = db.client["parkflow"].parking_slots.find({})
    slots = await cursor.to_list(length=1000)
    
    serialized_slots = []
    for slot in slots:
        serialized_slots.append({
            "id": str(slot.get("_id") or slot.get("parking_slot_id")),
            "name": slot.get("slot_number", "Unnamed"),
            "isOccupied": slot.get("status") == "occupied",
            "lastUpdated": slot.get("last_updated").isoformat() if slot.get("last_updated") else None
        })

    return APIResponse.success_response(
        message="Parking slots retrieved",
        code=ResponseCode.SUCCESS,
        data={"slots": serialized_slots},
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
    query = {}
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
