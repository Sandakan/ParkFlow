from fastapi import APIRouter, Depends
from app.api.deps import get_current_admin
from app.core.database import db
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.settings import (
    InferenceSettingsResponse,
    InferenceSettingsUpdateRequest,
)
from app.models.settings import InferenceSettingsInDB
from datetime import datetime, timezone

router = APIRouter()


@router.get("/inference", response_model=APIResponse[InferenceSettingsResponse])
async def get_inference_settings(admin=Depends(get_current_admin)):
    settings_doc = await db.client["parkflow"].settings.find_one({"_id": "inference"})

    if not settings_doc:
        defaults = InferenceSettingsInDB()
        return APIResponse.success_response(
            message="Settings fetched",
            data=InferenceSettingsResponse(**defaults.model_dump()),
            code=ResponseCode.SETTINGS_FETCHED,
        )

    return APIResponse.success_response(
        message="Settings fetched",
        data=InferenceSettingsResponse(**settings_doc),
        code=ResponseCode.SETTINGS_FETCHED,
    )


@router.get("/inference/public", response_model=APIResponse[InferenceSettingsResponse])
async def get_inference_settings_public():
    settings_doc = await db.client["parkflow"].settings.find_one({"_id": "inference"})

    if not settings_doc:
        defaults = InferenceSettingsInDB()
        return APIResponse.success_response(
            data=InferenceSettingsResponse(**defaults.model_dump())
        )

    return APIResponse.success_response(data=InferenceSettingsResponse(**settings_doc))


@router.put("/inference", response_model=APIResponse[InferenceSettingsResponse])
async def update_inference_settings(
    settings_req: InferenceSettingsUpdateRequest, admin=Depends(get_current_admin)
):
    update_data = settings_req.model_dump()
    update_data["updated_at"] = datetime.now(timezone.utc)

    await db.client["parkflow"].settings.update_one(
        {"_id": "inference"}, {"$set": update_data}, upsert=True
    )

    return APIResponse.success_response(
        message="Settings updated successfully",
        data=InferenceSettingsResponse(**update_data),
        code=ResponseCode.SETTINGS_UPDATED,
    )
