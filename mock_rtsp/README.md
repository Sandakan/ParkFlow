# Mock RTSP Server

This is a lightweight Dockerized utility built on Alpine Linux that creates a simulation environment for live RTSP streams. It uses **MediaMTX** as the core RTSP server and **Python/FFmpeg** to continuously loop your input files (videos or images) and broadcast them across concurrent network paths.

## Key Features

- **Smart Media Handling**: Supports `.mp4`, `.avi`, `.jpg`, `.png`, and `.webp`.
- **Automatic Scaling**: Injects FFmpeg filters to handle odd-dimension media (e.g., 2121x1414) that typically crash standard H.264 encoders.
- **Python Powered**: Robust process management with native JSON configuration parsing.
- **Unbuffered Logs**: Immediate feedback in your terminal via `docker logs`.
- **Zero-Config Fallback**: Scans the `/assets` folder and streams everything automatically if no config is provided.

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
> **The backend stack must be started first.** The mock RTSP server joins the `parkflow-backend` network that is created by the backend's `docker-compose.yml`. Always start the backend before starting `mock_rtsp`.

### Start the Server & Watch for Changes

Builds the image and starts the container. This command will keep the terminal open, showing live logs and automatically rebuilding/syncing when you change files:

```bash
docker compose up --build --watch
```

> [!NOTE]
> The RTSP URLs for the streams will be printed in the terminal logs as soon as the container starts. Look for lines starting with `URL: rtsp://...`.

### Background Mode (No Watch)

If you just want to run it in the background:

```bash
docker compose up -d
```

### Watch Logs

To monitor the streams and see live FFmpeg logs:

```bash
docker compose logs -f
```

### Stop and Remove

```bash
docker compose down
```

### After `docker prune` (network not found error)

If you see `network parkflow-backend not found`, it means Docker's networks were pruned. Fix:

```bash
# 1. Restart the backend stack first (it creates parkflow-net)
cd ../backend
docker compose up --build --watch

# 2. Then start mock_rtsp in a separate terminal
cd ../mock_rtsp
docker compose up --watch
```

---

## 3. Configuration (`stream_config.json`)

Use the `stream_config.json` in the root of this folder to define your cameras. This allows you to map specific files in the `assets/` folder to unique RTSP URL paths.

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

## 4. Manual Usage (Docker Run)

To run the mock server manually (without Compose):

```bash
docker run -d --name mock-rtsp \
  -v "./assets:/assets" \
  -v "./stream_config.json:/stream_config.json" \
  -p 8554:8554 \
  mock-rtsp
```

### Accessing the Streams

Once the container is running, the streams are available at the following URLs:

- **Localhost (for VLC/FFplay):** `rtsp://localhost:8554/front_gate`
- **Container-to-Container (for the Backend):** `rtsp://mock-rtsp:8554/front_gate`

---

## 4. Management Commands

Use these commands to manage the container lifecycle:

### View Live Logs

Keep track of stream status and RTMP/RTSP connections:

```bash
docker logs -f my-mock-rtsp
```

### Stop the Server

```bash
docker stop my-mock-rtsp
```

### Start the Server (if already created)

```bash
docker start my-mock-rtsp
```

### Remove the Container

```bash
docker rm -f my-mock-rtsp
```

---

## 5. Advanced Options

### Environment Variables

- `PYTHONUNBUFFERED=1`: (Enabled by default in Dockerfile) Ensures real-time logging in the console.
- `CONFIG_FILE`: Path to the JSON configuration inside the container (Default: `/stream_config.json`).

### Fallback Behavior

- **Folder Scan**: If no `stream_config.json` is mounted or found, the server automatically scans `/assets/` and starts a stream for every file it finds (using the filename as the stream path).
- **Test Pattern**: If the `/assets/` folder is empty, the server generates a default live color-bar test pattern at `rtsp://localhost:8554/test_pattern`.
