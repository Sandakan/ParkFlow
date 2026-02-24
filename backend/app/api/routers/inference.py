from fastapi import APIRouter, File, UploadFile, HTTPException, Depends
from fastapi.responses import StreamingResponse
from app.ai.inference import process_parking_image
from app.ai.stream_manager import ParkingStreamManager
from app.api.deps import get_current_user
from app.schemas.response import APIResponse, ResponseCode
from app.models.parking_slot import ParkingSlotInDB
from app.models.parking_lot import ParkingLotInDB
from app.core.database import db

router = APIRouter()


@router.post("/image", response_model=APIResponse[dict])
async def process_image(
    lot_id: str,
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user),
):
    """
    Upload a single image of a parking lot.
    The system will fetch the dynamic bounding boxes for the lot_id from the DB,
    run the YOLO inference, and return the occupancy statistics.
    """
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image")

    # Read the image bytes
    image_bytes = await file.read()

    # Fetch all parking slots (polygons) from the DB for this lot_id
    cursor = db.client["parkflow"].parking_slots.find({"lot_id": lot_id})
    slots = await cursor.to_list(length=1000)

    if not slots:
        return APIResponse.error_response(
            code=ResponseCode.NOT_FOUND,
            message="No parking slots found for this lot ID. Please define slots first.",
            status_code=404,
        )

    # Process the image with our AI logic
    occupancy_data, annotated_image = process_parking_image(image_bytes, slots)

    if "error" in occupancy_data:
        return APIResponse.error_response(
            code=ResponseCode.INTERNAL_SERVER_ERROR,
            message=f"AI Inference failed: {occupancy_data['error']}",
            status_code=500,
        )

    return APIResponse.success_response(
        message="Image processed successfully", data=occupancy_data
    )


@router.get("/stream/raw/{lot_id}")
async def stream_raw(
    lot_id: str,
):  # , current_user: dict = Depends(get_current_active_user)):
    """
    Streams the raw (unprocessed) video feed for the specified lot_id.
    """
    # Fetch the parking lot to get the RTSP URL
    lot_doc = await db.client["parkflow"].parking_lots.find_one({"_id": lot_id})
    if not lot_doc or "rtsp_url" not in lot_doc:
        raise HTTPException(
            status_code=404, detail="Parking lot or stream URL not found"
        )

    rtsp_url = lot_doc["rtsp_url"]

    return StreamingResponse(
        ParkingStreamManager.stream_raw_video(rtsp_url),
        media_type="multipart/x-mixed-replace; boundary=frame",
    )


@router.get("/stream/processed/{lot_id}")
async def stream_processed(
    lot_id: str,
):  # , current_user: dict = Depends(get_current_active_user)):
    """
    Streams the processed video feed (with YOLO bounding boxes) for the lot_id.
    """
    # Fetch the parking lot to get the RTSP URL
    lot_doc = await db.client["parkflow"].parking_lots.find_one({"_id": lot_id})
    if not lot_doc or "rtsp_url" not in lot_doc:
        raise HTTPException(
            status_code=404, detail="Parking lot or stream URL not found"
        )

    rtsp_url = lot_doc["rtsp_url"]

    # Fetch the dynamic bounding boxes for inference
    cursor = db.client["parkflow"].parking_slots.find({"lot_id": lot_id})
    slots = await cursor.to_list(length=1000)

    if not slots:
        raise HTTPException(
            status_code=404, detail="No parking slots defined for this lot"
        )

    return StreamingResponse(
        ParkingStreamManager.stream_processed_video(rtsp_url, slots),
        media_type="multipart/x-mixed-replace; boundary=frame",
    )
