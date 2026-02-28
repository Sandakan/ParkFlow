# Use a lightweight Alpine image
FROM alpine:3.19

# Install ffmpeg, curl and python3
RUN apk add --no-cache ffmpeg curl python3

# Ensure Python output is sent straight to terminal without buffering
ENV PYTHONUNBUFFERED=1

# Copy our assets folder into the container
COPY assets/ /assets/

# Copy the stream configuration file (can be overridden by mounting over it)
COPY stream_config.json /stream_config.json

# Add our python entrypoint script
COPY rtsp_server.py /rtsp_server.py

# Start script
ENTRYPOINT ["python3", "/rtsp_server.py"]
