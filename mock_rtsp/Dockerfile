# Use a lightweight Alpine image
FROM alpine:3.19

# Install ffmpeg, curl and python3
RUN apk add --no-cache ffmpeg curl python3

# Ensure Python output is sent straight to terminal without buffering
ENV PYTHONUNBUFFERED=1

# Download and install MediaMTX and its default config
ENV MEDIAMTX_VERSION="1.6.0"
RUN curl -L https://github.com/bluenviron/mediamtx/releases/download/v${MEDIAMTX_VERSION}/mediamtx_v${MEDIAMTX_VERSION}_linux_amd64.tar.gz | tar zx -C /usr/local/bin mediamtx mediamtx.yml && \
    mv /usr/local/bin/mediamtx.yml /mediamtx.yml

# Copy our assets folder into the container
COPY assets/ /assets/

# Copy the stream configuration file (can be overridden by mounting over it)
COPY stream_config.json /stream_config.json

# Add our python entrypoint script
COPY rtsp_server.py /rtsp_server.py

# Expose MediaMTX ports (RTSP, RTMP, HLS, WebRTC)
EXPOSE 8554 1935 8888 8889

# Start script
ENTRYPOINT ["python3", "/rtsp_server.py"]
