import os
import json
import subprocess
import time
import signal
import sys
from pathlib import Path

RTSP_PORT = 8554
ASSETS_DIR = Path("/assets")
CONFIG_FILE = Path(os.getenv("CONFIG_FILE", "/stream_config.json"))
MEDIAMTX_PATH = "/usr/local/bin/mediamtx"
MEDIAMTX_CONFIG = "/mediamtx.yml"

processes = []

def signal_handler(sig, frame):
    print("\nShutting down RTSP server...")
    for p in processes:
        p.terminate()
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

def stream_file(file_path, stream_name):
    """Starts an ffmpeg process to stream a file in a loop."""
    ext = file_path.suffix.lower()
    is_image = ext in ['.jpg', '.jpeg', '.png', '.webp']
    
    rtsp_url = f"rtsp://localhost:{RTSP_PORT}/{stream_name}"
    print(f"--> Starting RTSP stream '{stream_name}' for {file_path}")
    print(f"    URL: {rtsp_url}")

    # Build ffmpeg command
    cmd = ["ffmpeg", "-re"]
    
    if is_image:
        cmd += ["-loop", "1", "-i", str(file_path)]
    else:
        cmd += ["-stream_loop", "-1", "-i", str(file_path)]
        
    # Add scaling filter for odd dimensions
    cmd += ["-vf", "scale=trunc(iw/2)*2:trunc(ih/2)*2"]
    
    # Video encoding settings
    cmd += ["-c:v", "libx264", "-preset", "ultrafast", "-tune", "zerolatency", "-pix_fmt", "yuv420p"]
    
    # Audio for video files
    if not is_image:
        cmd += ["-c:a", "aac"]
        
    cmd += ["-f", "rtsp", rtsp_url, "-v", "error"]

    while True:
        process = subprocess.Popen(cmd)
        processes.append(process)
        process.wait()
        processes.remove(process)
        print(f"Stream '{stream_name}' ended. Restarting in 2 seconds...")
        time.sleep(2)

def main():
    print("=================================================")
    print("Mock RTSP Server (Python) starting...")
    print(f"MediaMTX configurations loaded from {MEDIAMTX_CONFIG}")
    print("=================================================")

    # 1. Start MediaMTX
    try:
        mediamtx = subprocess.Popen([MEDIAMTX_PATH, MEDIAMTX_CONFIG])
        processes.append(mediamtx)
    except Exception as e:
        print(f"Failed to start MediaMTX: {e}")
        sys.exit(1)

    time.sleep(2)

    # 2. Determine what to stream
    streams_to_start = []

    if CONFIG_FILE.exists():
        print(f"Configuration file found at {CONFIG_FILE}. Parsing streams...")
        try:
            with open(CONFIG_FILE, 'r') as f:
                config = json.load(f)
                for stream in config.get("streams", []):
                    name = stream.get("name")
                    filename = stream.get("file")
                    file_path = ASSETS_DIR / filename
                    if file_path.exists():
                        streams_to_start.append((file_path, name))
                    else:
                        print(f"Error: Configured file '{filename}' not found in {ASSETS_DIR}!")
        except Exception as e:
            print(f"Error parsing config file: {e}")

    if not streams_to_start:
        if not CONFIG_FILE.exists():
            print(f"No {CONFIG_FILE} found. Scanning {ASSETS_DIR} for media files...")
        else:
            print(f"No valid streams found in config. Scanning {ASSETS_DIR} as fallback...")
            
        if ASSETS_DIR.exists():
            for file in ASSETS_DIR.iterdir():
                if file.is_file():
                    streams_to_start.append((file, file.stem))

    if not streams_to_start:
        print("Warning: No files found to stream!")
        print("Falling back to generating a test pattern...")
        
        test_pattern_cmd = [
            "ffmpeg", "-re", "-f", "lavfi", "-i", "testsrc=size=1280x720:rate=30",
            "-f", "lavfi", "-i", "sine=frequency=1000:sample_rate=48000",
            "-c:v", "libx264", "-preset", "ultrafast", "-tune", "zerolatency",
            "-c:a", "aac", "-f", "rtsp", f"rtsp://localhost:{RTSP_PORT}/test_pattern"
        ]
        test_pattern_proc = subprocess.Popen(test_pattern_cmd)
        processes.append(test_pattern_proc)
        mediamtx.wait()
        return

    # 3. Start stream threads/processes
    import threading
    for file_path, stream_name in streams_to_start:
        t = threading.Thread(target=stream_file, args=(file_path, stream_name), daemon=True)
        t.start()

    print("=================================================")
    print("All streams initialized successfully.")
    print(f"MediaMTX is running on port {RTSP_PORT}")
    print("=================================================")

    # Keep main thread alive
    mediamtx.wait()

if __name__ == "__main__":
    main()
