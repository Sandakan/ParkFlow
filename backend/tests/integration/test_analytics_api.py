import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from app.api.deps import get_current_admin
from app.main import app
from app.schemas.response import ResponseCode


@pytest.fixture
def override_get_current_admin():
    mock_admin = MagicMock()
    mock_admin.user_id = "admin123"
    mock_admin.role = "admin"
    app.dependency_overrides[get_current_admin] = lambda: mock_admin
    yield mock_admin
    app.dependency_overrides.clear()


@pytest.mark.asyncio
async def test_analytics_overview_api(client, override_get_current_admin):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_lots_cursor = MagicMock()
        mock_lots_cursor.to_list = AsyncMock(return_value=[])
        mock_db.parking_lots.find.return_value = mock_lots_cursor

        mock_agg_cursor = MagicMock()
        mock_agg_cursor.to_list = AsyncMock(return_value=[{"total": 5000.0}])
        mock_db.reservations.aggregate.return_value = mock_agg_cursor

        mock_db.parking_slots.count_documents = AsyncMock(return_value=100)
        mock_db.occupancy_logs.count_documents = AsyncMock(return_value=10)
        mock_db.cameras.find.return_value = MagicMock(
            to_list=AsyncMock(return_value=[])
        )

        mock_db.occupancy_logs.find.return_value = MagicMock(
            to_list=AsyncMock(return_value=[])
        )

        response = client.get("/api/v1/analytics/overview")

        assert response.status_code == 200
        data = response.json()
        assert data["code"] == ResponseCode.SUCCESS
        assert data["data"]["revenueToday"] == 5000.0


@pytest.mark.asyncio
async def test_ai_health_api(client, override_get_current_admin):
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_client.__getitem__.return_value = mock_db

        mock_logs_cursor = MagicMock()
        mock_logs_cursor.sort.return_value = mock_logs_cursor
        mock_logs_cursor.limit.return_value = mock_logs_cursor
        mock_logs_cursor.to_list = AsyncMock(
            return_value=[{"confidence_score": 0.95}, {"confidence_score": 0.85}]
        )
        mock_db.occupancy_logs.find.return_value = mock_logs_cursor

        with patch("psutil.cpu_percent", return_value=15.5):
            response = client.get("/api/v1/analytics/ai-health")

            assert response.status_code == 200
            data = response.json()
            assert data["code"] == ResponseCode.SUCCESS
            assert data["data"]["avgConfidence"] == 0.9
            assert data["data"]["systemCpuPct"] == 15.5
