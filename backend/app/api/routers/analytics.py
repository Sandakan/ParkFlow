from datetime import datetime, timezone, timedelta
from typing import Any, List
from bson import ObjectId

from fastapi import APIRouter, Depends, Query

from app.api.deps import get_current_admin
from app.core.database import db
from app.core.logging import logger
from app.schemas.response import APIResponse, ResponseCode

router = APIRouter()


@router.get(
    "/overview",
    response_model=APIResponse[dict],
    summary="Analytics vitals — capacity, occupancy, stream health, dwell time",
)
async def get_analytics_overview(
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """Aggregate real-time KPI vitals across all parking lots."""

    lots_cursor = db.client["parkflow"].parking_lots.find({"deleted_at": None})
    lots = await lots_cursor.to_list(length=2000)
    total_slots_count = await db.client["parkflow"].parking_slots.count_documents(
        {"deleted_at": None}
    )
    total_capacity = total_slots_count
    occupied_count = await db.client["parkflow"].parking_slots.count_documents(
        {"deleted_at": None, "status": "occupied"}
    )
    vacant_count = total_slots_count - occupied_count
    occupancy_rate = (
        (occupied_count / total_slots_count) if total_slots_count > 0 else 0.0
    )

    cameras_cursor = db.client["parkflow"].cameras.find({"deleted_at": None})
    cameras = await cameras_cursor.to_list(length=1000)
    total_camera_count = len(cameras)
    active_stream_count = 0

    for cam in cameras:
        cam_id = str(cam["_id"])
        # Find all active mappings for this camera
        cursor = db.client["parkflow"].camera_slot_mappings.find(
            {"camera_id": cam_id, "deleted_at": None}
        )
        mappings = await cursor.to_list(length=100)

        # Check if at least one mapping points to a non-deleted slot
        is_active = False
        for m in mappings:
            slot = await db.client["parkflow"].parking_slots.find_one(
                {"_id": ObjectId(m["slot_id"]), "deleted_at": None}
            )
            if slot:
                is_active = True
                mapping = m
                break

        if is_active:
            updated_at = mapping.get("updated_at")
            if updated_at:
                age = datetime.now(timezone.utc) - updated_at.replace(
                    tzinfo=timezone.utc
                )
                if age.total_seconds() < 600:
                    active_stream_count += 1
            else:
                active_stream_count += 1

    stream_health_pct = (
        active_stream_count / total_camera_count if total_camera_count > 0 else 0.0
    )

    # 4. Average dwell time (minutes) for sessions ending today
    today_start = datetime.now(timezone.utc).replace(
        hour=0, minute=0, second=0, microsecond=0
    )

    checkout_cursor = db.client["parkflow"].occupancy_logs.find(
        {"event_type": "check-out", "created_at": {"$gte": today_start}}
    )
    checkouts = await checkout_cursor.to_list(length=5000)

    dwell_times: List[float] = []
    for co in checkouts:
        slot_id = co.get("slot_id")
        co_time = co["created_at"].replace(tzinfo=timezone.utc)

        # Find the most recent check-in before this check-out
        last_ci = await db.client["parkflow"].occupancy_logs.find_one(
            {
                "slot_id": slot_id,
                "event_type": "check-in",
                "created_at": {"$lt": co["created_at"]},
            },
            sort=[("created_at", -1)],
        )

        if last_ci:
            ci_time = last_ci["created_at"].replace(tzinfo=timezone.utc)
            dwell_minutes = (co_time - ci_time).total_seconds() / 60.0
            if 0 < dwell_minutes < 1440:  # 24h cap
                dwell_times.append(dwell_minutes)

    avg_dwell_time = (sum(dwell_times) / len(dwell_times)) if dwell_times else 0.0

    # 5. Financials
    month_start = datetime.now(timezone.utc).replace(
        day=1, hour=0, minute=0, second=0, microsecond=0
    )

    checkins_today_count = await db.client["parkflow"].occupancy_logs.count_documents(
        {"event_type": "check-in", "created_at": {"$gte": today_start}}
    )

    async def calculate_revenue(start_date: datetime) -> float:
        """Sum total_billed_price from reservations completed since start_date."""
        pipeline = [
            {
                "$match": {
                    "status": "completed",
                    "check_out_time": {"$gte": start_date},
                    "deleted_at": None,
                }
            },
            {"$group": {"_id": None, "total": {"$sum": "$total_billed_price"}}},
        ]
        cursor = db.client["parkflow"].reservations.aggregate(pipeline)
        result = await cursor.to_list(length=1)
        return result[0]["total"] if result else 0.0

    revenue_today = await calculate_revenue(today_start)
    revenue_month = await calculate_revenue(month_start)

    # 6. Turnover rate today — number of distinct check-in events per total slot count
    turnover_rate = (
        (checkins_today_count / total_slots_count) if total_slots_count > 0 else 0.0
    )

    return APIResponse.success_response(
        message="Analytics overview retrieved",
        code=ResponseCode.SUCCESS,
        data={
            "totalCapacity": total_capacity,
            "totalSlotsCount": total_slots_count,
            "currentOccupied": occupied_count,
            "currentVacant": vacant_count,
            "occupancyRate": round(occupancy_rate, 4),
            "activeStreamCount": active_stream_count,
            "totalCameraCount": total_camera_count,
            "streamHealthPct": round(stream_health_pct, 4),
            "avgDwellTimeMinutes": round(avg_dwell_time, 2),
            "turnoverRateToday": round(turnover_rate, 2),
            "revenueToday": round(revenue_today, 2),
            "revenueMonth": round(revenue_month, 2),
        },
    )


@router.get(
    "/occupancy-trend",
    response_model=APIResponse[dict],
    summary="Time-series occupancy trend bucketed by period",
)
async def get_occupancy_trend(
    period: str = Query("24h", description="One of: 24h, 7d, 30d"),
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Returns an occupancy percentage time-series for the given period.
    'Today' series + 'comparison' series (prior equivalent period).

    The series is constructed from occupancy_log events (check-in / check-out)
    by computing a running net occupancy count per time bucket.
    """
    now = datetime.now(timezone.utc)

    if period == "24h":
        bucket_hours = 1
        num_buckets = 24
        period_start = now - timedelta(hours=24)
        comp_start = now - timedelta(hours=48)
        comp_end = now - timedelta(hours=24)
        label_fmt = "%H:%M"
    elif period == "7d":
        bucket_hours = 24
        num_buckets = 7
        period_start = now - timedelta(days=7)
        comp_start = now - timedelta(days=14)
        comp_end = now - timedelta(days=7)
        label_fmt = "%a"
    else:  # 30d
        bucket_hours = 24
        num_buckets = 30
        period_start = now - timedelta(days=30)
        comp_start = now - timedelta(days=60)
        comp_end = now - timedelta(days=30)
        label_fmt = "%d %b"

    total_slots_count = await db.client["parkflow"].parking_slots.count_documents(
        {"deleted_at": None}
    )
    if total_slots_count == 0:
        total_slots_count = 1  # avoid div-by-zero, return 0% occupancy

    async def build_series(start: datetime, end: datetime) -> list:
        """Build occupancy percentage and revenue points for each bucket between start and end."""
        cursor = (
            db.client["parkflow"]
            .occupancy_logs.find(
                {
                    "created_at": {"$gte": start, "$lte": end},
                    "deleted_at": None,
                }
            )
            .sort("created_at", 1)
        )
        events = await cursor.to_list(length=50000)

        # Calculate initial occupancy at start time
        cis_before = await db.client["parkflow"].occupancy_logs.count_documents(
            {"event_type": "check-in", "created_at": {"$lt": start}}
        )
        cos_before = await db.client["parkflow"].occupancy_logs.count_documents(
            {"event_type": "check-out", "created_at": {"$lt": start}}
        )
        initial_occupied = max(0, cis_before - cos_before)

        # Fetch completed reservations for financial bucket revenue
        res_cursor = db.client["parkflow"].reservations.find(
            {
                "status": "completed",
                "check_out_time": {"$gte": start, "$lte": end},
                "deleted_at": None,
            }
        )
        completed_reservations = await res_cursor.to_list(length=20000)

        points = []
        running_occupied = initial_occupied

        for i in range(num_buckets):
            bucket_start = start + timedelta(hours=bucket_hours * i)
            bucket_end = start + timedelta(hours=bucket_hours * (i + 1))

            bucket_events = [
                e
                for e in events
                if bucket_start
                <= e["created_at"].replace(tzinfo=timezone.utc)
                < bucket_end
            ]

            for e in bucket_events:
                e_type = e.get("event_type")
                if e_type == "check-in":
                    running_occupied += 1
                elif e_type == "check-out":
                    running_occupied = max(0, running_occupied - 1)

            bucket_revenue = sum(
                r.get("total_billed_price", 0.0)
                for r in completed_reservations
                if bucket_start
                <= r["check_out_time"].replace(tzinfo=timezone.utc)
                < bucket_end
            )

            label = bucket_end.strftime(label_fmt)
            occupancy_pct = min(1.0, running_occupied / total_slots_count)
            points.append(
                {
                    "label": label,
                    "occupancy": round(occupancy_pct, 4),
                    "revenue": round(bucket_revenue, 2),
                }
            )

        return points

    current_points = await build_series(period_start, now)
    comparison_points = await build_series(comp_start, comp_end)

    return APIResponse.success_response(
        message="Occupancy and revenue trend retrieved",
        code=ResponseCode.SUCCESS,
        data={
            "period": period,
            "points": current_points,
            "comparisonPoints": comparison_points,
        },
    )


@router.get(
    "/ai-health",
    response_model=APIResponse[dict],
    summary="AI engine health: detection confidence mean and system load",
)
async def get_ai_health(
    current_admin: Any = Depends(get_current_admin),
) -> Any:
    """
    Returns the average YOLO detection confidence from the last 1000 log entries,
    plus current system CPU usage and a stub for inference latency.
    """
    cursor = (
        db.client["parkflow"]
        .occupancy_logs.find({"deleted_at": None})
        .sort("created_at", -1)
        .limit(1000)
    )
    logs = await cursor.to_list(length=1000)

    confidences = [log["confidence_score"] for log in logs if "confidence_score" in log]
    avg_confidence = (sum(confidences) / len(confidences)) if confidences else 0.0

    system_cpu_pct: float | None = None
    inference_latency_ms: float | None = None
    try:
        import psutil

        system_cpu_pct = psutil.cpu_percent(interval=0.1)
    except ImportError:
        logger.warning("psutil not available — CPU metrics will be null")

    return APIResponse.success_response(
        message="AI health metrics retrieved",
        code=ResponseCode.SUCCESS,
        data={
            "avgConfidence": round(avg_confidence, 4),
            "sampleCount": len(confidences),
            "systemCpuPct": system_cpu_pct,
            "inferenceLatencyMs": inference_latency_ms,
        },
    )
