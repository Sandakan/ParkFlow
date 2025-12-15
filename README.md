# ParkFlow - Intelligent Parking Management System

ParkFlow is a final-year implementation of a Smart Parking System integrating Computer Vision (YOLOv8) with a real-time mobile dashboard.

## Architecture

**Monorepo Structure:**

* **backend/**: Python FastAPI + YOLOv8 (AI Inference & Business Logic)
* **frontend/**: Flutter Mobile/Web App (Driver & Admin Interfaces)
* **Infrastructure**: PostgreSQL + Redis (via Docker, backend-specific)

## Quick Start

### Without Docker (Windows)

#### 1. Start Backend (Terminal A)

1. **Navigate to Backend Directory**:

   ```powershell
   cd backend
   ```

2. **Create Virtual Environment**:

   ```powershell
   python -m venv venv
   .\venv\Scripts\activate
   ```

3. **Install Dependencies**:

   ```powershell
   pip install -r requirements.txt
   ```

4. **Run the Backend**:

   ```powershell
   uvicorn app.main:app --reload
   ```

*Docs available at: <http://localhost:8000/docs>*

#### 2. Start Frontend (Terminal B)

1. **Navigate to Frontend Directory**:

   ```powershell
   cd frontend
   ```

2. **Run Flutter Application**:

   ```powershell
   flutter run
   ```

### With Docker (Backend Only)

#### 1. Start Backend Infrastructure

1. **Navigate to Backend Directory**:

   ```powershell
   cd backend
   ```

2. **Install Docker Desktop**: Ensure Docker is installed and running.
3. **Build and Start Containers**:

   ```powershell
   docker build -t parkflow-backend:dev .
   docker-compose up -d
   ```

4. **Access the Application**:
   * Backend: <http://localhost:8000>
   * Swagger Docs: <http://localhost:8000/docs>

#### 2. Start Frontend (Terminal B)

1. **Navigate to Frontend Directory**:

   ```powershell
   cd frontend
   ```

2. **Run Flutter Application**:

   ```powershell
   flutter run
   ```

### Updating Containers When Files Change

1. **Rebuild the Containers**:
   If you make changes to the code or dependencies, rebuild the containers:

   ```powershell
   docker build -t parkflow-backend:dev .
   docker-compose up -d
   ```

2. **Using `docker-compose watch`**:
   Install the `docker-compose-watch` tool to automatically rebuild containers when files change:

   ```powershell
   pip install docker-compose-watch
   docker-compose-watch
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

## Tech Stack

* **AI:** YOLOv8, OpenCV
* **Backend:** FastAPI, SQLAlchemy, AsyncPG
* **Frontend:** Flutter, Riverpod, Flutter Map
* **Database:** PostgreSQL (JSONB support for coordinates)
