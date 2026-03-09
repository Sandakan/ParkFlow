import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.main import app
from app.api.deps import get_current_user, get_current_admin
from app.schemas.response import ResponseCode


@pytest.fixture
def override_admin():
    mock_admin = MagicMock()
    mock_admin.user_id = "admin123"
    mock_admin.role = "admin"
    app.dependency_overrides[get_current_admin] = lambda: mock_admin
    yield mock_admin
    app.dependency_overrides.clear()


@pytest.fixture
def override_user():
    mock_user = MagicMock()
    mock_user.user_id = "user123"
    app.dependency_overrides[get_current_user] = lambda: mock_user
    yield mock_user
    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_process_image_api(client, override_user):
    with patch("app.api.routers.inference.process_parking_image") as mock_process:
        mock_process.return_value = ({"occupied": 5, "vacant": 10}, b"fake_image")

        with patch("app.core.database.db.client") as mock_client:
            mock_db = MagicMock()
            mock_client.__getitem__.return_value = mock_db

            mock_cursor = MagicMock()
            mock_cursor.to_list = AsyncMock(return_value=[{"_id": "slot1"}])
            mock_db.parking_slots.find.return_value = mock_cursor

            with patch(
                "app.api.routers.inference.get_inference_settings",
                new_callable=AsyncMock,
            ) as mock_settings:
                mock_settings_obj = MagicMock()
                mock_settings.return_value = mock_settings_obj

                files = {"file": ("test.jpg", b"fake_bytes", "image/jpeg")}
                response = client.post(
                    "/api/v1/inference/image?lot_id=lot123", files=files
                )

                assert response.status_code == 200
                data = response.json()
                assert data["code"] == ResponseCode.SUCCESS
                assert data["data"]["occupied"] == 5


@pytest.mark.asyncio
async def test_inference_status_api(client, override_admin):
    with patch(
        "app.ai.inference_manager.inference_manager.running_camera_ids"
    ) as mock_running:
        mock_running.return_value = ["cam1", "cam2"]

        response = client.get("/api/v1/inference/control/status")

        assert response.status_code == 200
        data = response.json()
        assert data["data"]["count"] == 2
        assert "cam1" in data["data"]["running_cameras"]


@pytest.mark.asyncio
async def test_start_all_inference_api(client, override_admin):
    with patch(
        "app.ai.inference_manager.inference_manager.start_all", new_callable=AsyncMock
    ) as mock_start:
        with patch(
            "app.ai.inference_manager.inference_manager.running_camera_ids"
        ) as mock_running:
            mock_running.return_value = ["cam1"]

            response = client.post("/api/v1/inference/control/start-all")

            assert response.status_code == 200
            mock_start.assert_called_once()
            data = response.json()
            assert data["code"] == ResponseCode.SUCCESS
