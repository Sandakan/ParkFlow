import pytest
from unittest.mock import patch, MagicMock, AsyncMock
import numpy as np
from app.ai.detector import run_frame, DetectedBox, FrameResult, SlotHit
from app.ai.redis_state import get_stable_state, push_detection

# --- AI Detector Tests ---


@pytest.mark.parametrize(
    "vehicle_coords, slot_coords, expected_occupied",
    [
        # Vehicle inside slot
        (
            (0.1, 0.1, 0.2, 0.2),
            [
                {"x": 0.0, "y": 0.0},
                {"x": 0.3, "y": 0.0},
                {"x": 0.3, "y": 0.3},
                {"x": 0.0, "y": 0.3},
            ],
            True,
        ),
        # Vehicle outside slot
        (
            (0.4, 0.4, 0.5, 0.5),
            [
                {"x": 0.0, "y": 0.0},
                {"x": 0.3, "y": 0.0},
                {"x": 0.3, "y": 0.3},
                {"x": 0.0, "y": 0.3},
            ],
            False,
        ),
        # Vehicle partially inside, its center is outside
        (
            (0.25, 0.25, 0.5, 0.5),
            [
                {"x": 0.0, "y": 0.0},
                {"x": 0.3, "y": 0.0},
                {"x": 0.3, "y": 0.3},
                {"x": 0.0, "y": 0.3},
            ],
            False,
        ),
    ],
)
def test_run_frame_logic(vehicle_coords, slot_coords, expected_occupied):
    with patch("app.ai.detector._get_model") as mock_get_model:
        mock_model = MagicMock()
        mock_get_model.return_value = mock_model

        mock_prediction = MagicMock()
        mock_boxes = MagicMock()

        x1, y1, x2, y2 = vehicle_coords
        mock_boxes.xyxyn.cpu().numpy.return_value = np.array([[x1, y1, x2, y2]])
        mock_boxes.conf.cpu().numpy.return_value = np.array([0.9])
        mock_boxes.cls.cpu().numpy.return_value = np.array([2])
        mock_boxes.__len__.return_value = 1

        mock_prediction.boxes = mock_boxes
        mock_model.predict.return_value = [mock_prediction]
        mock_model.names = {2: "car"}

        mappings = [
            {"_id": "mapping123", "slot_id": "slot123", "coordinates": slot_coords}
        ]

        frame = np.zeros((100, 100, 3), dtype=np.uint8)
        result = run_frame(frame, mappings)

        assert len(result.detections) == 1
        assert result.detections[0].label == "car"
        assert len(result.slot_hits) == 1
        assert result.slot_hits[0].is_occupied == expected_occupied


@pytest.mark.asyncio
async def test_get_stable_state_logic():
    mock_redis = AsyncMock()
    camera_id = "cam1"
    mapping_id = "map1"

    # Test stable occupied (all 1s)
    mock_redis.lrange.return_value = [b"1", b"1", b"1"]
    state = await get_stable_state(mock_redis, camera_id, mapping_id, threshold=3)
    assert state is True

    # Test stable vacant (all 0s)
    mock_redis.lrange.return_value = [b"0", b"0", b"0"]
    state = await get_stable_state(mock_redis, camera_id, mapping_id, threshold=3)
    assert state is False

    # Test unstable (mixed)
    mock_redis.lrange.return_value = [b"1", b"0", b"1"]
    state = await get_stable_state(mock_redis, camera_id, mapping_id, threshold=3)
    assert state is None

    # Test insufficient data
    mock_redis.lrange.return_value = [b"1", b"1"]
    state = await get_stable_state(mock_redis, camera_id, mapping_id, threshold=3)
    assert state is None


@pytest.mark.asyncio
async def test_push_detection_logic():
    mock_redis = AsyncMock()
    camera_id = "cam1"
    mapping_id = "map1"

    await push_detection(
        mock_redis, camera_id, mapping_id, is_occupied=True, buffer_size=10
    )

    key = f"buffer:{camera_id}:{mapping_id}"
    mock_redis.lpush.assert_called_once_with(key, "1")
    mock_redis.ltrim.assert_called_once_with(key, 0, 9)
    mock_redis.expire.assert_called_once_with(key, 3600)
