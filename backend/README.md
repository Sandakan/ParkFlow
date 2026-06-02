# ParkFlow Backend (AI & API)

Official repository: [github.com/Sandakan/ParkFlow](https://github.com/Sandakan/ParkFlow)

## 🗂️ Structure (Service-Repository Pattern)

All core application code resides in the `app/` directory:

* **app/api/**: Route controllers (Endpoints).
* **app/services/**: Business logic. Includes `reservation_service.py` and `ai_service.py`.
* **app/repositories/**: Database interactions.
* **app/models/**: ODM models (using Motor/Pydantic).
* **app/schemas/**: Pydantic models (Data Transfer Objects).
* **app/core/**: Configuration, database connection, and security.

## Setup

### 1. Environment Variables

Create a `.env` file in the `backend/` directory with the following:

```env
MONGODB_URL=mongodb://localhost:27017/parkflow
REDIS_URL=redis://localhost:6379
SECRET_KEY=your-super-secret-key
```

### 2. Without Docker (Local Development)

1. **Install Python**: Ensure Python 3.10+ is installed.
2. **Create Virtual Environment**:

   ```powershell
   python -m venv venv
   .\venv\Scripts\activate
   ```

3. **Install Dependencies**:

   ```powershell
   pip install -r requirements.txt
   ```

4. **Run the Application**:

   ```powershell
   uvicorn app.main:app --reload --port 8200
   ```

### 3. With Docker (Recommended)

1. **Build and Start Containers**:

   ```powershell
   docker compose up -d --build
   ```

2. **Access the Application**:
   * API: <http://localhost:8200>
   * Swagger Docs: <http://localhost:8200/docs>

   > **Windows Note — Port 8200**: The host-facing port is **8200** because Windows reserves the port 8000 range. The container still listens internally on **8000**.

#### 🚀 GPU Acceleration (CUDA) inside Docker
If you have an NVIDIA GPU (e.g., RTX 50-series Blackwell card) and want to accelerate inference with CUDA inside the container:
1. Ensure the **NVIDIA Container Toolkit** is installed on your Windows host / WSL2 backend.
2. In Docker Desktop, make sure **"Use the WSL 2 based engine"** is enabled under settings.
3. The `backend` container is configured to request GPU resources automatically via `deploy.resources` in `docker-compose.yml`.
4. The Dockerfile upgrades `pip` and installs `torch` and `torchvision` compiled with **CUDA 12.8** to natively support newer card architectures (e.g., compute capability `sm_120`).
5. Upon container startup, verify GPU detection in the backend logs:
   `CUDA Availability: True | Detected GPU: NVIDIA GeForce RTX 5070`

## AI Logic

The system uses **YOLOv26** (via the `ultralytics` library) for vehicle detection. Models are loaded dynamically per session to optimize memory usage.

### Testing AI Inference Locally

To verify that the AI inference logic is correctly processing RTSP URLs:

1. Start the `mock-rtsp` Docker container from the root project folder.
2. Execute the inference test script inside the backend container:

   ```bash
   docker exec parkflow-backend python /app/test_inference.py
   ```

3. The script will pull real-time frames from the RTSP server, apply detection, and save outputs in the `backend/tmp_frames/` directory.

## Testing

Run tests using pytest:

```bash
pytest
```

Tests include mocking for both MongoDB (mongomock-motor) and Redis (fakeredis).
