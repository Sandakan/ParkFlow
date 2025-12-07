# ParkFlow Backend (AI & API)

This service handles the Computer Vision processing and API endpoints.

## 📂 Structure (Service-Repository Pattern)

* **api/**: Route controllers (Endpoints).
* **services/**: Business logic. `ai_service.py` contains the YOLOv8 logic.
* **repositories/**: Database interactions.
* **models/**: SQLAlchemy database tables.
* **schemas/**: Pydantic models (Data Transfer Objects).

## Setup

1. **Env Setup**: Ensure `venv` is active.
2. **Environment Variables**: Check `.env` for DB credentials.
3. **Run**: `uvicorn app.main:app --reload`

## AI Logic

The YOLOv8 model is initialized in `services/ai_service.py` as a singleton to prevent memory overhead. Do not initialize the model inside a route function.
