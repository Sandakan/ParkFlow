from typing import Any, List
from fastapi import APIRouter, Depends, status
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.models.parking_slot import ParkingSlotInDB
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
