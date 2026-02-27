from typing import Any, Optional
from fastapi import APIRouter, Depends, status, Query
from app.api.deps import get_current_user, get_current_admin
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.parking import CreateCameraRequest
from app.core.database import db

router = APIRouter()

@router.get(
    "/",
    response_model=APIResponse[dict],
    description="Retrieve the list of all cameras.",
)
async def get_all_cameras(
    current_user: Any = Depends(get_current_admin),
) -> Any:
    """
    Get all cameras across all parking lots.
    """
    cursor = db.client["parkflow"].cameras.find({"deleted_at": None})
    cameras = await cursor.to_list(length=1000)
    
    serialized_cameras = []
    
    # We may want to fetch the lot names to display them
    # But for efficiency, we can just return lot_id and let frontend or joining do it
    # We perform a simple lookup for lot names
    lot_ids = list(set([cam.get("lot_id") for cam in cameras if cam.get("lot_id")]))
    from bson import ObjectId
    valid_lot_ids = [ObjectId(lid) for lid in lot_ids if len(str(lid)) == 24]
    
    lots_cursor = db.client["parkflow"].parking_lots.find({"_id": {"$in": valid_lot_ids}})
    lots = await lots_cursor.to_list(length=1000)
    lot_map = {str(lot.get("_id")): lot.get("name", "Unknown Lot") for lot in lots}
    
    for cam in cameras:
        lot_id = cam.get("lot_id")
        serialized_cameras.append({
            "id": str(cam.get("_id")),
            "name": cam.get("name"),
            "rtspUrl": cam.get("rtsp_url"),
            "lotId": lot_id,
            "lotName": lot_map.get(str(lot_id), "Unknown Lot"),
            "createdAt": cam.get("created_at").isoformat() if cam.get("created_at") else None,
            "updatedAt": cam.get("updated_at").isoformat() if cam.get("updated_at") else None,
        })

    return APIResponse.success_response(
        message="Cameras retrieved",
        code=ResponseCode.SUCCESS,
        data={"cameras": serialized_cameras},
    )

@router.post(
    "/",
    response_model=APIResponse[dict],
    description="Add a new camera.",
    status_code=status.HTTP_201_CREATED,
)
async def create_camera(
    request: CreateCameraRequest,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Create a new camera.
    """
    from datetime import datetime, timezone
    now = datetime.now(timezone.utc)
    
    new_camera = {
        "lot_id": request.lot_id,
        "name": request.name,
        "rtsp_url": request.rtsp_url,
        "created_at": now,
        "updated_at": now,
        "deleted_at": None,
    }
    
    result = await db.client["parkflow"].cameras.insert_one(new_camera)

    return APIResponse.success_response(
        message="Camera added successfully",
        code=ResponseCode.SUCCESS,
        data={"id": str(result.inserted_id)},
        status_code=status.HTTP_201_CREATED
    )

@router.get(
    "/lot/{lot_id}",
    response_model=APIResponse[dict],
    description="Retrieve the list of cameras for a specific parking lot.",
)
async def get_parking_lot_cameras(
    lot_id: str,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Get all cameras for a lot.
    """
    cursor = db.client["parkflow"].cameras.find({"lot_id": lot_id, "deleted_at": None})
    cameras = await cursor.to_list(length=100)
    
    serialized_cameras = []
    for cam in cameras:
        serialized_cameras.append({
            "id": str(cam.get("_id")),
            "name": cam.get("name"),
            "rtspUrl": cam.get("rtsp_url"),
            "lotId": cam.get("lot_id"),
            "createdAt": cam.get("created_at").isoformat() if cam.get("created_at") else None,
            "updatedAt": cam.get("updated_at").isoformat() if cam.get("updated_at") else None,
        })

    return APIResponse.success_response(
        message="Cameras retrieved",
        code=ResponseCode.SUCCESS,
        data={"cameras": serialized_cameras},
    )

@router.delete(
    "/{camera_id}",
    response_model=APIResponse[dict],
    description="Delete a specific camera by ID.",
)
async def delete_camera(
    camera_id: str,
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Soft delete a camera.
    """
    from bson import ObjectId
    from datetime import datetime, timezone
    
    result = await db.client["parkflow"].cameras.update_one(
        {"_id": ObjectId(camera_id), "deleted_at": None},
        {
            "$set": {
                "deleted_at": datetime.now(timezone.utc)
            }
        }
    )

    if result.matched_count == 0:
        return APIResponse.error_response(
            message="Camera not found",
            code=ResponseCode.NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND
        )

    return APIResponse.success_response(
        message="Camera deleted successfully",
        code=ResponseCode.SUCCESS,
    )
