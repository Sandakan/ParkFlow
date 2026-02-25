#!/bin/sh

RTSP_PORT=8554

echo "================================================="
echo "Mock RTSP Server starting..."
echo "MediaMTX configurations loaded from /mediamtx.yml"
echo "Scanning /assets for media files..."
echo "================================================="

# Start mediamtx in the background
/usr/local/bin/mediamtx /mediamtx.yml &
MEDIAMTX_PID=$!

# Wait for MediaMTX to start accepting connections
sleep 2

# Check if /assets directory has any files
ASSET_COUNT=$(find /assets -type f | wc -l)

if [ "$ASSET_COUNT" -eq 0 ]; then
    echo "Warning: No files found in /assets directory!"
    echo "Falling back to generating a test pattern..."
    echo ""
    echo "Example Usage:"
    echo "  docker run -v /path/to/myvideo.mp4:/assets/input.mp4 -p 8554:8554 mock-rtsp"
    echo "================================================="
    
    # Generate an infinite test pattern and push to RTSP
    ffmpeg -re -f lavfi -i testsrc=size=1280x720:rate=30 \
           -f lavfi -i sine=frequency=1000:sample_rate=48000 \
           -c:v libx264 -preset ultrafast -tune zerolatency \
           -c:a aac -f rtsp rtsp://localhost:$RTSP_PORT/test_pattern
    
    # Keep container running
    wait $MEDIAMTX_PID
    exit $?
fi

# Function to run ffmpeg in an infinite loop
stream_file() {
    local INPUT_FILE=$1
    local STREAM_NAME=$2
    
    # Extract extension and convert to lowercase
    local EXTENSION=$(echo "${INPUT_FILE##*.}" | tr '[:upper:]' '[:lower:]')
    
    echo "--> Starting RTSP stream '$STREAM_NAME' for $INPUT_FILE"
    echo "    URL: rtsp://localhost:$RTSP_PORT/$STREAM_NAME"

    while true; do
        if [ "$EXTENSION" = "jpg" ] || [ "$EXTENSION" = "png" ] || [ "$EXTENSION" = "jpeg" ] || [ "$EXTENSION" = "webp" ]; then
            # Loop the image as a 30fps video
            # Hide the standard output of ffmpeg to avoid log spam, outputting only errors
            ffmpeg -re -loop 1 -i "$INPUT_FILE" \
                   -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
                   -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p \
                   -f rtsp rtsp://localhost:$RTSP_PORT/$STREAM_NAME -v error
        else
            # Default to transcoding video to ensure compatibility with all RTSP clients
            ffmpeg -re -stream_loop -1 -i "$INPUT_FILE" \
                   -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
                   -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac \
                   -f rtsp rtsp://localhost:$RTSP_PORT/$STREAM_NAME -v error
        fi
        
        # If the file drops, wait a bit and restart it
        sleep 2
    done
}

CONFIG_FILE=${CONFIG_FILE:-/stream_config.json}

if [ -f "$CONFIG_FILE" ]; then
    echo "Configuration file found at $CONFIG_FILE. Parsing streams..."
    
    # Read streams array from JSON
    # Format expected: { "streams": [ {"name": "cam1", "file": "vid1.mp4"}, ... ] }
    LENGTH=$(jq '.streams | length' "$CONFIG_FILE")
    
    if [ "$LENGTH" -gt 0 ]; then
        for i in $(seq 0 $(($LENGTH - 1))); do
            STREAM_NAME=$(jq -r ".streams[$i].name" "$CONFIG_FILE")
            FILENAME=$(jq -r ".streams[$i].file" "$CONFIG_FILE")
            FILE_PATH="/assets/$FILENAME"
            
            if [ -f "$FILE_PATH" ]; then
                stream_file "$FILE_PATH" "$STREAM_NAME" &
            else
                echo "Error: Configured file '$FILENAME' not found in /assets!"
            fi
        done
    else
        echo "No streams configured in $CONFIG_FILE."
    fi
else
    echo "No $CONFIG_FILE found. Scanning /assets for all media files..."
    # Start a background stream for each file in /assets
    for FILE in /assets/*; do
        if [ -f "$FILE" ]; then
            # Get filename without path and extension to use as stream name
            # E.g., "/assets/myvideo.mp4" -> "myvideo"
            FILENAME=$(basename "$FILE")
            STREAM_NAME="${FILENAME%.*}"
            
            # Run it in background
            stream_file "$FILE" "$STREAM_NAME" &
        fi
    done
fi

echo "================================================="
echo "All streams initialized successfully."
echo "MediaMTX is running on port $RTSP_PORT"
echo "================================================="

wait $MEDIAMTX_PID
