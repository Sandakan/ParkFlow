# ParkFlow Backend (AI & API)

This service handles the Computer Vision processing and API endpoints.

## 🗂️ Structure (Service-Repository Pattern)

* **api/**: Route controllers (Endpoints).
* **services/**: Business logic. `ai_service.py` contains the YOLOv8 logic.
* **repositories/**: Database interactions.
* **models/**: SQLAlchemy database tables.
* **schemas/**: Pydantic models (Data Transfer Objects).

## Setup

### Without Docker (Windows)

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

4. **Set Environment Variables**:
   Create a `.env` file with the following:

   ```env
   DATABASE_URL=postgresql://user:password@localhost:5432/parkflow
   ```

5. **Run the Application**:

   ```powershell
   uvicorn app.main:app --reload
   ```

### With Docker

1. **Navigate to Backend Directory**:

   ```powershell
   cd backend
   ```

2. **Install Docker Desktop**: Ensure Docker is installed and running.
3. **Build and Start Containers**:

   ```powershell
   docker compose up -d --build
   ```

4. **Access the Application**:
   * Backend: <http://localhost:8000>
   * Swagger Docs: <http://localhost:8000/docs>

### Updating Containers When Files Change

1. **Rebuild the Containers**:
   If you make changes to the code or dependencies, rebuild the containers:

   ```powershell
   docker compose up -d --build
   ```

2. **Using `docker-compose watch`**:
   Install the `docker-compose-watch` tool to automatically rebuild containers when files change:

   ```powershell
   pip install docker-compose-watch
   docker compose watch
   ```

### Tagging Containers

1. **Build with a Tag**:
   You can tag the backend container during the build process:

   ```powershell
   docker build -t parkflow-backend:dev .
   ```

2. **Push Tagged Images**:
   Push the tagged image to a container registry:

   ```powershell
   docker tag parkflow-backend:dev your-repo/backend:v1.0
   docker push your-repo/backend:v1.0
   ```

## AI Logic

The YOLOv26 model is initialized in `ai/loader.py` dynamically per parking lot to prevent memory overhead. Do not initialize the model inside a route function.

### Testing AI Inference Locally

To verify that the AI inference logic is correctly processing RTSP URLs without spinning up the frontend:

1. Start the `mock-rtsp` Docker container from the root project folder (ensure it's attached to the `backend_default` network as discussed in its README).
2. Execute the inference test script directly inside the backend container:

   ```bash
   docker exec parkflow-backend python /app/test_inference.py
   ```

3. The script will pull real-time frames from the RTSP server, apply dynamic bounding boxes using YOLO, and save annotated outputs as JPEG frames in the `backend/tmp_frames/` directory for visual verification.
