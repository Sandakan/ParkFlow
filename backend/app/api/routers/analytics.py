from datetime import datetime, timezone, timedelta
from typing import Any, List

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
    total_capacity: int = sum(lot.get("total_slots", 0) for lot in lots)

    total_slots_count = await db.client["parkflow"].parking_slots.count_documents(
        {"deleted_at": None}
    )
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
        mapping = await db.client["parkflow"].camera_slot_mappings.find_one(
            {"camera_id": cam_id, "deleted_at": None}
        )
        if mapping:
            # Consider a stream "active" if its mapping was updated within the last 10 minutes
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

    # 4. Average dwell time (minutes) from occupancy_logs:
    #    pair check-in / check-out events for the same slot, average the duration
    today_start = datetime.now(timezone.utc).replace(
        hour=0, minute=0, second=0, microsecond=0
    )

    checkin_cursor = db.client["parkflow"].occupancy_logs.find(
        {"event_type": "check-in", "created_at": {"$gte": today_start}}
    )
    checkins = await checkin_cursor.to_list(length=5000)
    checkout_cursor = db.client["parkflow"].occupancy_logs.find(
        {"event_type": "check-out", "created_at": {"$gte": today_start}}
    )
    checkouts = await checkout_cursor.to_list(length=5000)
    checkout_map: dict = {}
    for co in checkouts:
        slot_id = co.get("slot_id", "")
        checkout_map.setdefault(slot_id, []).append(
            co["created_at"].replace(tzinfo=timezone.utc)
        )

    dwell_times: List[float] = []
    for ci in checkins:
        slot_id = ci.get("slot_id", "")
        ci_time = ci["created_at"].replace(tzinfo=timezone.utc)
        if slot_id in checkout_map:
            # Find the first checkout after this check-in
            matching = [t for t in checkout_map[slot_id] if t > ci_time]
            if matching:
                co_time = min(matching)
                dwell_minutes = (co_time - ci_time).total_seconds() / 60.0
                if 0 < dwell_minutes < 720:  # sanity cap at 12 hours
                    dwell_times.append(dwell_minutes)

    avg_dwell_time = (sum(dwell_times) / len(dwell_times)) if dwell_times else 0.0

    # 5. Financials: Revenue Today and Month
    month_start = datetime.now(timezone.utc).replace(
        day=1, hour=0, minute=0, second=0, microsecond=0
    )

    # Map slot_id -> price_per_hour
    slot_id_to_price: dict = {}
    lot_map = {str(lot["_id"]): lot for lot in lots}
    slots_cursor = db.client["parkflow"].parking_slots.find({"deleted_at": None})
    async for slot in slots_cursor:
        l_id = str(slot.get("lot_id"))
        if l_id in lot_map:
            slot_id_to_price[str(slot["_id"])] = lot_map[l_id].get(
                "price_per_hour", 0.0
            )

    async def calculate_revenue(start_date: datetime) -> float:
        rev = 0.0
        # For revenue, we only count COMPLETED stays where check-out happened in the period
        ci_cursor = db.client["parkflow"].occupancy_logs.find(
            {
                "event_type": "check-in",
                "created_at": {"$gte": start_date - timedelta(days=2)},
            }  # buffer for long stays
        )
        cis = await ci_cursor.to_list(length=10000)
        co_cursor = db.client["parkflow"].occupancy_logs.find(
            {"event_type": "check-out", "created_at": {"$gte": start_date}}
        )
        cos = await co_cursor.to_list(length=10000)

        # slot_id -> list of check-ins
        ci_map: dict = {}
        for ci in cis:
            ci_map.setdefault(str(ci["slot_id"]), []).append(ci)

        for co in cos:
            s_id = str(co["slot_id"])
            co_time = co["created_at"].replace(tzinfo=timezone.utc)
            price = slot_id_to_price.get(s_id, 0.0)
            if price <= 0:
                continue

            # Find the check-in immediately preceding this check-out
            prev_cis = [
                c
                for c in ci_map.get(s_id, [])
                if c["created_at"].replace(tzinfo=timezone.utc) < co_time
            ]
            if prev_cis:
                last_ci = max(prev_cis, key=lambda x: x["created_at"])
                ci_time = last_ci["created_at"].replace(tzinfo=timezone.utc)
                hours = (co_time - ci_time).total_seconds() / 3600.0
                rev += hours * price
        return rev

    revenue_today = await calculate_revenue(today_start)
    revenue_month = await calculate_revenue(month_start)

    # 6. Turnover rate today — number of distinct check-in events per total slot count
    turnover_rate = (
        (len(checkins) / total_slots_count) if total_slots_count > 0 else 0.0
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

    slot_id_to_price: dict = {}
    lots_cursor = db.client["parkflow"].parking_lots.find({"deleted_at": None})
    lots = await lots_cursor.to_list(length=1000)
    lot_map = {str(lot["_id"]): lot for lot in lots}
    slots_cursor = db.client["parkflow"].parking_slots.find({"deleted_at": None})
    async for slot in slots_cursor:
        l_id = str(slot.get("lot_id"))
        if l_id in lot_map:
            slot_id_to_price[str(slot["_id"])] = lot_map[l_id].get(
                "price_per_hour", 0.0
            )

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

        overlap_ci_cursor = db.client["parkflow"].occupancy_logs.find(
            {
                "event_type": "check-in",
                "created_at": {"$gte": start - timedelta(days=2), "$lt": start},
                "deleted_at": None,
            }
        )
        overlap_cis = await overlap_ci_cursor.to_list(length=50000)

        ci_history: dict = {}
        for ci in overlap_cis + [
            e for e in events if e.get("event_type") == "check-in"
        ]:
            ci_history.setdefault(str(ci["slot_id"]), []).append(ci)

        points = []
        running_occupied = 0

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

            bucket_revenue = 0.0
            for e in bucket_events:
                s_id = str(e["slot_id"])
                e_type = e.get("event_type")
                if e_type == "check-in":
                    running_occupied += 1
                elif e_type == "check-out":
                    running_occupied = max(0, running_occupied - 1)

                    # Calculate revenue for this check-out
                    price = slot_id_to_price.get(s_id, 0.0)
                    if price > 0:
                        co_time = e["created_at"].replace(tzinfo=timezone.utc)
                        # Find the check-in immediately preceding this check-out
                        prev_cis = [
                            c
                            for c in ci_history.get(s_id, [])
                            if c["created_at"].replace(tzinfo=timezone.utc) < co_time
                        ]
                        if prev_cis:
                            last_ci = max(prev_cis, key=lambda x: x["created_at"])
                            ci_time = last_ci["created_at"].replace(tzinfo=timezone.utc)
                            hours = (co_time - ci_time).total_seconds() / 3600.0
                            if hours > 0:
                                bucket_revenue += hours * price

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
