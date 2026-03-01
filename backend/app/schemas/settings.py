from pydantic import BaseModel, Field


class InferenceSettingsResponse(BaseModel):
    confidence_threshold: float
    iou_threshold: float
    frame_skip: int
    stability_buffer: int


class InferenceSettingsUpdateRequest(BaseModel):
    confidence_threshold: float = Field(ge=0.01, le=1.0)
    iou_threshold: float = Field(ge=0.01, le=1.0)
    frame_skip: int = Field(ge=1, le=10)
    stability_buffer: int = Field(ge=1, le=100)
