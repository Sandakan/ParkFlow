# ParkFlow - Intelligent Parking Management System

ParkFlow is a final-year implementation of a Smart Parking System integrating Computer Vision (YOLOv8) with a real-time mobile dashboard.

## Architecture

**Monorepo Structure:**

* **backend/**: Python FastAPI + YOLOv8 (AI Inference & Business Logic)
* **frontend/**: Flutter Mobile/Web App (Driver & Admin Interfaces)
* **Infrastructure**: PostgreSQL + Redis (via Docker)

## Quick Start
<!-- 
### 1. Start Infrastructure
```bash
docker-compose up -d
``` -->

### 1. Start Backend (Terminal A)

```bash
cd backend
source venv/bin/activate
uvicorn app.main:app --reload
```

*Docs available at: <http://localhost:8000/docs>*

### 2. Start Frontend (Terminal B)

```bash
cd frontend
flutter run
```

## Tech Stack

* **AI:** YOLOv8, OpenCV
* **Backend:** FastAPI, SQLAlchemy, AsyncPG
* **Frontend:** Flutter, Riverpod, Flutter Map
* **Database:** PostgreSQL (JSONB support for coordinates)
