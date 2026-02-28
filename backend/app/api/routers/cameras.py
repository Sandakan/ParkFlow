from typing import Any, Optional
from fastapi import APIRouter, Depends, status, Query
from app.api.deps import get_current_user, get_current_admin
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.parking import CreateCameraRequest
from app.core.database import db
from pydantic import BaseModel

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

class WebRTCOffer(BaseModel):
    sdp: str
    type: str

@router.post(
    "/{camera_id}/webrtc/offer",
    response_model=APIResponse[dict],
    description="Exchange WebRTC offer for an answer to stream camera via WebRTC.",
)
async def webrtc_offer(
    camera_id: str,
    offer: WebRTCOffer,
    current_user: Any = Depends(get_current_user),
) -> Any:
    """
    Process WebRTC offer, connect to MediaMTX WHEP API natively, and return WebRTC answer.
    """
    from bson import ObjectId
    import httpx
    from urllib.parse import urlparse
    import os

    camera = await db.client["parkflow"].cameras.find_one({"_id": ObjectId(camera_id), "deleted_at": None})
    if not camera:
        return APIResponse.error_response(
            message="Camera not found",
            code=ResponseCode.NOT_FOUND,
            status_code=status.HTTP_404_NOT_FOUND
        )

    rtsp_url = camera.get("rtsp_url")
    if not isinstance(rtsp_url, str) or not rtsp_url:
        return APIResponse.error_response(
            message="Camera RTSP URL not configured",
            code=ResponseCode.ERROR,
            status_code=status.HTTP_400_BAD_REQUEST
        )

    parsed = urlparse(rtsp_url)
    hostname = parsed.hostname
    
    # If standard hostname is localhost/127.0.0.1, we must route internally to the host adapter from Docker
    if os.path.exists('/.dockerenv') and hostname in ['localhost', '127.0.0.1']:
        hostname = 'host.docker.internal'
    
    # Send WHEP application/sdp POST to MediaMTX
    # Note: Using a fixed mediamtx host because MediaMTX controls the streams
    mediamtx_host = 'host.docker.internal' if os.path.exists('/.dockerenv') else 'localhost'
    
    # 1. Dynamically tell MediaMTX to proxy this RTSP stream (if it hasn't already)
    # Using sourceOnDemand=True means MediaMTX will only connect to the IP Camera when someone watches
    api_url = f"http://{mediamtx_host}:9997/v3/config/paths/add/{camera_id}"
    
    try:
        async with httpx.AsyncClient() as client:
            # We ignore 400 Bad Request because it usually means "path already exists" which is fine!
            await client.post(
                api_url,
                json={
                    "source": rtsp_url,
                    "sourceOnDemand": True
                },
                timeout=5.0
            )
            
            # 2. Now that MediaMTX knows about the path, request a WebRTC WHEP session for it
            whep_url = f"http://{mediamtx_host}:8889/{camera_id}/whep"
            
            resp = await client.post(
                whep_url,
                headers={"Content-Type": "application/sdp"},
                content=offer.sdp,
                timeout=10.0
            )

        if resp.status_code not in (200, 201):
            return APIResponse.error_response(
                message=f"RTSP Server WebRTC failed with {resp.status_code}: {resp.text}",
                code=ResponseCode.ERROR,
                status_code=status.HTTP_400_BAD_REQUEST
            )

        answer_sdp = resp.text
        return APIResponse.success_response(
            message="WebRTC Answer created",
            code=ResponseCode.SUCCESS,
            data={
                "sdp": answer_sdp,
                "type": "answer"
            }
        )

    except Exception as e:
        return APIResponse.error_response(
            message=f"Failed to communicate with RTSP WebRTC endpoint: {str(e)}",
            code=ResponseCode.INTERNAL_SERVER_ERROR,
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
