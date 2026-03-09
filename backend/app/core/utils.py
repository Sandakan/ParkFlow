import os
from urllib.parse import urlparse


def get_internal_rtsp_url(rtsp_url: str) -> str:
    """
    Rewrites a public RTSP URL (e.g., localhost, 127.0.0.1, or host LAN IP)
    to be suitable for internal backend/container access, targeting the
    MediaMTX service name if in Docker.
    """
    if not isinstance(rtsp_url, str) or not rtsp_url:
        return rtsp_url

    parsed = urlparse(rtsp_url)
    hostname = parsed.hostname

    is_docker = os.path.exists("/.dockerenv")

    local_identifiers = ["localhost", "127.0.0.1", "host.docker.internal"]
    if hostname and (hostname.startswith("192.168.") or hostname.startswith("10.")):
        local_identifiers.append(hostname)

    if hostname in local_identifiers and is_docker:
        hostname = "mediamtx"
    elif hostname in ["localhost", "127.0.0.1"]:
        hostname = "127.0.0.1"

    port = parsed.port if parsed.port else 8554
    proxy_rtsp_url = f"rtsp://{hostname}:{port}{parsed.path}"
    if parsed.query:
        proxy_rtsp_url += f"?{parsed.query}"

    return proxy_rtsp_url
