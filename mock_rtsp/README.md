# Mock RTSP Server

This is a lightweight Docker image built on Alpine Linux that creates a mock RTSP stream. It uses `mediamtx` as the RTSP server and `ffmpeg` to continuously loop your input files (videos or images) and push them to concurrent streams.

## Build the Image

Run the following command in this directory:

```bash
docker build -t mock-rtsp .
```

## How to Use

The server is designed to stream everything inside its internal `/assets` folder. Therefore, any files you place in the local `assets/` folder will automatically act as distinct RTSP streams when the container starts.

### 1. Starting with your Assets folder

To mount your local files, ensure you map your local directory to `/assets` inside the container:

```bash
docker run -d --name my-mock-rtsp \
  -v "C:\absolute\path\to\your\mock_rtsp\assets:/assets" \
  -p 8554:8554 \
  mock-rtsp
```

If the folder contains files like `test_image.png` and `vid1.mp4`, the server will start the following streams automatically:

- `rtsp://localhost:8554/test_image`
- `rtsp://localhost:8554/vid1`

### 2. Custom Stream Configuration

If you want to control exactly which files are streamed, or if you want to give them custom RTSP URLs (like `/cam1` instead of `/vid1`), you can use the `stream_config.json` file located in the root directory.

Edit `stream_config.json` before building your docker image:

```json
{
  "streams": [
    { "name": "front_gate_camera", "file": "vid1.mp4" },
    { "name": "parking_lot_a", "file": "test_image.png" }
  ]
}
```

If a valid configuration file exists, the server will **only** stream the files configured inside it. If the file is deleted or disabled, it falls back to streaming everything inside `/assets/`.

### 3. Starting without any files (Test Pattern)

If the `/assets` folder is completely empty, the server will fall back to generating a continuous default test audio and video pattern at `rtsp://localhost:8554/test_pattern`.

## Accessing the Streams

By default, streams are broadcasted to paths mirroring their filename without extensions on port `8554`. You can view them using VLC, ffplay, or connect to them via your backend AI services:

**URL Example:** `rtsp://localhost:8554/test_image`

If you are connecting from another docker container on the same network, you should use the container name as the host:

**URL Example:** `rtsp://my-mock-rtsp:8554/test_image`
