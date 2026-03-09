import pytest
import os
from app.core.utils import get_internal_rtsp_url


def test_get_internal_rtsp_url_localhost():
    url = "rtsp://localhost:8554/mystream"
    result = get_internal_rtsp_url(url)
    assert result == "rtsp://127.0.0.1:8554/mystream"


def test_get_internal_rtsp_url_remote():
    url = "rtsp://1.2.3.4:8554/remote"
    result = get_internal_rtsp_url(url)
    assert result == url


def test_get_internal_rtsp_url_docker_mapping(monkeypatch):
    monkeypatch.setattr(
        os.path, "exists", lambda x: True if x == "/.dockerenv" else False
    )

    url = "rtsp://localhost:8554/docker"
    result = get_internal_rtsp_url(url)
    assert result == "rtsp://mediamtx:8554/docker"


def test_get_internal_rtsp_url_with_query():
    url = "rtsp://localhost:8554/query?user=test&pass=secret"
    result = get_internal_rtsp_url(url)
    assert result == "rtsp://127.0.0.1:8554/query?user=test&pass=secret"


def test_get_internal_rtsp_url_invalid_input():
    assert get_internal_rtsp_url(None) is None
    assert get_internal_rtsp_url("") == ""
    assert get_internal_rtsp_url(123) == 123
