# ParkFlow - Intelligent Parking Management System

[![ParkFlow Repository](https://img.shields.io/badge/GitHub-Sandakan%2FParkFlow-blue?logo=github)](https://github.com/Sandakan/ParkFlow)

![ParkFlow Banner Image](other/banner.jpg)

ParkFlow is a final-year implementation of a Smart Parking System integrating Computer Vision (YOLOv26) with a real-time mobile dashboard. Official repository: [github.com/Sandakan/ParkFlow](https://github.com/Sandakan/ParkFlow)

## Architecture

**Monorepo Structure:**

* **backend/**: Python FastAPI + YOLOv26/Ultralytics (AI Inference & Business Logic)
* **frontend/**: Flutter Mobile Application (Driver & Admin Interfaces)
* **mock_rtsp/**: Lightweight Dockerized MediaMTX server to simulate live RTSP streams
* **Infrastructure**: MongoDB + Redis (via Docker)

## 🚀 Getting Started from Scratch

Follow these steps to set up the entire ParkFlow ecosystem on your local machine.

### 1. Prerequisites

Ensure you have the following installed:

* **Docker & Docker Desktop**: For infrastructure and mock streams.
* **Flutter SDK (Stable)**: For the mobile application.
* **Python 3.10+**: For local backend development/testing.
* **Git**: To manage the source code.

### 2. Initial Configuration

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Sandakan/ParkFlow.git
   cd ParkFlow
   ```

2. **Backend Environment**:
   Navigate to `backend/`, create a `.env` file:

   ```env
   MONGODB_URL=your_mongodb_atlas_connection_string
   REDIS_URL=redis://redis:6379
   SECRET_KEY=generate_a_secure_random_string
   ```

3. **Frontend API Keys**:
   * **Google Maps**: Obtain an API key from [Google Cloud Console](https://console.cloud.google.com/).
   * **Android**: Add `MAPS_API_KEY=your_key` to `frontend/android/local.properties`.
   * **iOS**: Create `frontend/ios/Flutter/Secrets.xcconfig` and add `MAPS_API_KEY=your_key`.

### 3. Launching the Stack

Run these in separate terminals:

**Terminal 1: Backend Infrastructure**

```bash
cd backend
docker compose up -d --build
```

*Wait for containers to be healthy. Access docs at <http://localhost:8200/docs>.*

**Terminal 2: Mock RTSP Streams**

```bash
cd mock_rtsp
docker compose up -d --build
```

*This simulates live cameras using the assets in `mock_rtsp/assets`.*

**Terminal 3: Frontend App**

```bash
cd frontend
flutter pub get
flutter run
```

---

## 🛠️ Troubleshooting

* **Port 8200 Reservation**: If Docker fails to bind to port 8200 on Windows, it's likely reserved by another service. Run `netsh interface ipv4 show excludedportrange protocol=tcp` to find a free port and update the `docker-compose.yml` mapping.
* **Map Not Loading**: Ensure your Google Maps API key has the "Maps SDK for Android/iOS" enabled and billing is configured (if applicable).
* **AI Model Path**: If you get a "weights not found" error, ensure `backend/app/ai/models/best.pt` exists and the path in `backend/app/core/config.py` correctly points to `/app/ai/models/best.pt` inside the container.

---

## Tech Stack

* **AI:** YOLOv26 (Ultralytics), OpenCV
* **Backend:** FastAPI, Motor (Async MongoDB), Redis
* **Frontend:** Flutter, Riverpod, Google Maps
* **Database:** MongoDB
* **Infrastructure:** Docker, MediaMTX (RTSP)
