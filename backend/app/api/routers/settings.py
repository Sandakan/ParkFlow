from fastapi import APIRouter, Depends
from app.api.deps import get_current_admin
from app.core.database import db, get_inference_settings
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.settings import (
    InferenceSettingsResponse,
    InferenceSettingsUpdateRequest,
)
from app.models.settings import InferenceSettingsInDB
from app.ai.inference_manager import inference_manager
from datetime import datetime, timezone

router = APIRouter()


@router.get("/inference", response_model=APIResponse[InferenceSettingsResponse])
async def fetch_inference_settings(admin=Depends(get_current_admin)):
    settings_obj = await get_inference_settings()
    return APIResponse.success_response(
        message="Settings fetched",
        data=InferenceSettingsResponse(**settings_obj.model_dump()),
        code=ResponseCode.SETTINGS_FETCHED,
    )


@router.get("/inference/public", response_model=APIResponse[InferenceSettingsResponse])
async def fetch_inference_settings_public():
    settings_obj = await get_inference_settings()
    return APIResponse.success_response(
        data=InferenceSettingsResponse(**settings_obj.model_dump())
    )


@router.put("/inference", response_model=APIResponse[InferenceSettingsResponse])
async def update_inference_settings(
    settings_req: InferenceSettingsUpdateRequest, admin=Depends(get_current_admin)
):
    prev = await get_inference_settings()

    update_data = settings_req.model_dump()
    update_data["updated_at"] = datetime.now(timezone.utc)

    await db.client["parkflow"].settings.update_one(
        {"_id": "inference"}, {"$set": update_data}, upsert=True
    )

    if settings_req.global_inference_enabled and not prev.global_inference_enabled:
        await inference_manager.start_all()
    elif not settings_req.global_inference_enabled and prev.global_inference_enabled:
        await inference_manager.stop_all()

    return APIResponse.success_response(
        message="Settings updated successfully",
        data=InferenceSettingsResponse(**update_data),
        code=ResponseCode.SETTINGS_UPDATED,
    )
