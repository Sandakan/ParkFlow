# Mock RTSP Server

Official repository: [github.com/Sandakan/ParkFlow](https://github.com/Sandakan/ParkFlow)

## Key Features

* **Smart Media Handling**: Supports `.mp4`, `.avi`, `.jpg`, `.png`, and `.webp`.
* **Automatic Scaling**: Handles odd-dimension media that typically crash standard H.264 encoders.
* **Low Latency**: Optimized for real-time AI inference testing.

---

## 1. Build the Image

From this directory, run:

```bash
docker build -t mock-rtsp .
```

---

## 2. Docker Compose (Recommended)

The easiest way to run the mock server is using Docker Compose.

> [!IMPORTANT]
> **The backend stack must be started first.** The mock RTSP server joins the `parkflow-backend` network created by the backend's `docker-compose.yml`.

### Start the Server & Watch for Changes

Builds the image and starts the container.

```bash
docker compose up -d --build
```

### Accessing the Streams

The RTSP URLs will be printed in the terminal logs. Look for lines starting with `URL: rtsp://...`.

* **Localhost (for VLC/FFplay):** `rtsp://localhost:8554/front_gate`
* **Container-to-Container (for Backend):** `rtsp://mock-rtsp:8554/front_gate` (using the container name or service name)

### Stop and Remove

```bash
docker compose down
```

### Network Troubleshooting

If you see `network parkflow-backend not found`, ensure the backend stack is running first:

```bash
cd ../backend
docker compose up -d
```

---

## 3. Configuration (`stream_config.json`)

Use `stream_config.json` to define your cameras and map files in the `assets/` folder to RTSP paths.

**Example `stream_config.json`:**

```json
{
  "streams": [
    { "name": "front_gate", "file": "vid1.mp4" },
    { "name": "parking_lot_a", "file": "test_image.png" }
  ]
}
```

---

## 4. Fallback Behavior

* **Folder Scan**: If no `stream_config.json` is found, the server scans `/assets/` and starts a stream for every file.
* **Test Pattern**: If the `/assets/` folder is empty, the server generates a default color-bar test pattern at `rtsp://localhost:8554/test_pattern`.
