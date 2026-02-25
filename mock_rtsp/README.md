# Mock RTSP Server

This is a lightweight Docker image built on Alpine Linux that creates a mock RTSP stream. It uses `mediamtx` as the RTSP server and `ffmpeg` to continuously loop your input files (videos or images) and push them to concurrent streams.

## Build the Image

Run the following command in this directory:

```bash
docker build -t mock-rtsp .
```

## How to Use

The server streams your media files based on the definitions in the `stream_config.json` file. If no configuration file is found, it will safely fall back to streaming everything inside the internal `/assets/` directory automatically.

### 1. Starting with your Assets folder

To mount your local files, ensure you map your local directory to `/assets` inside the container:

```bash
docker run -d --name my-mock-rtsp \
  --network backend_default \
  -v "C:\absolute\path\to\your\mock_rtsp\assets:/assets" \
  -p 8554:8554 \
  mock-rtsp
```

_Note: The `--network backend_default` flag connects the mock server to your existing ParkFlow backend network, allowing your API to resolve it by its container name `my-mock-rtsp`._

If the folder contains files like `test_image.png` and `vid1.mp4`, the server will start the following streams automatically:

- `rtsp://localhost:8554/test_image`
- `rtsp://localhost:8554/vid1`

### 2. Custom Stream Configuration

If you want to control exactly which files are streamed, or if you want to give them custom RTSP URLs (like `/cam1` instead of `/vid1`), you can use the `stream_config.json` file located in the root directory.

You can mount your configuration file live into the container:

```bash
docker run -d --name my-mock-rtsp \
  --network backend_default \
  -v "C:\absolute\path\to\your\mock_rtsp\assets:/assets" \
  -v "C:\absolute\path\to\your\mock_rtsp\stream_config.json:/stream_config.json" \
  -p 8554:8554 \
  mock-rtsp
```

If a valid configuration file over `/stream_config.json` exists, the server will **only** stream the files configured inside it. If the file is deleted or disabled, it falls back to streaming everything inside `/assets/`.

### 3. Starting without any files (Test Pattern)

If the `/assets` folder is completely empty, the server will fall back to generating a continuous default test audio and video pattern at `rtsp://localhost:8554/test_pattern`.

## Accessing the Streams

By default, streams are broadcasted to paths mirroring their filename without extensions on port `8554`. You can view them using VLC, ffplay, or connect to them via your backend AI services:

**URL Example:** `rtsp://localhost:8554/test_image`

If you are connecting from another docker container on the same network, you should use the container name as the host:

**URL Example:** `rtsp://my-mock-rtsp:8554/test_image`
