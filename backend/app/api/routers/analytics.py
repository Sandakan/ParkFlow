from datetime import datetime, timezone, timedelta
import io
from typing import Any, List
from bson import ObjectId
from jose import jwt, JWTError

from fastapi import APIRouter, Depends, Query, HTTPException, status
from fastapi.responses import StreamingResponse
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer

from app.api.deps import get_current_admin
from app.core.config import settings
from app.core.database import db
from app.core.logging import logger
from app.schemas.response import APIResponse, ResponseCode
from app.schemas.token import TokenPayload
from app.services.user_service import user_service

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


async def _get_admin_from_token(token: str) -> Any:
    """Helper to validate admin access via query param token."""
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (JWTError, Exception):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    user = await user_service.get_user(user_id=token_data.sub)
    if not user or user.role != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="The user doesn't have enough privileges",
        )
    return user


@router.get(
    "/report",
    summary="Generate PDF analytics report",
)
async def generate_analytics_report(
    token: str = Query(..., description="Admin access token"),
    period: str = Query("24h", description="One of: 24h, 7d, 30d"),
) -> Any:
    """
    Generates a modern PDF report for the given period.
    Securely validated via token query parameter.
    """
    await _get_admin_from_token(token)

    now = datetime.now(timezone.utc)
    if period == "24h":
        start_date = now - timedelta(hours=24)
        title_period = "Last 24 Hours"
    elif period == "7d":
        start_date = now - timedelta(days=7)
        title_period = "Last 7 Days"
    else:
        start_date = now - timedelta(days=30)
        title_period = "Last 30 Days"

    cursor = (
        db.client["parkflow"]
        .reservations.find(
            {
                "status": "completed",
                "check_out_time": {"$gte": start_date},
                "deleted_at": None,
            }
        )
        .sort("check_out_time", -1)
    )
    reservations = await cursor.to_list(length=5000)

    total_revenue = sum(r.get("total_billed_price", 0.0) for r in reservations)
    total_count = len(reservations)

    unique_slots = len(set(r.get("slot_id") for r in reservations if r.get("slot_id")))
    unique_users = len(set(r.get("user_id") for r in reservations if r.get("user_id")))

    buffer = io.BytesIO()
    doc = SimpleDocTemplate(
        buffer,
        pagesize=A4,
        rightMargin=40,
        leftMargin=40,
        topMargin=40,
        bottomMargin=40,
    )
    styles = getSampleStyleSheet()

    styles.add(
        ParagraphStyle(
            name="MainTitle",
            parent=styles["Title"],
            fontSize=24,
            textColor=colors.HexColor("#333233"),
            alignment=0,
            spaceAfter=6,
            fontName="Helvetica-Bold",
        )
    )
    styles.add(
        ParagraphStyle(
            name="MetaData",
            parent=styles["Normal"],
            fontSize=10,
            textColor=colors.HexColor("#666666"),
            spaceAfter=20,
        )
    )
    styles.add(
        ParagraphStyle(
            name="CardValue",
            fontSize=18,
            textColor=colors.HexColor("#333233"),
            fontName="Helvetica-Bold",
            alignment=1,
        )
    )
    styles.add(
        ParagraphStyle(
            name="CardLabel",
            fontSize=10,
            textColor=colors.HexColor("#666666"),
            fontName="Helvetica",
            alignment=1,
        )
    )

    elements = []

    elements.append(Paragraph("ParkFlow Analytics", styles["MainTitle"]))
    elements.append(Paragraph(f"REPORT — {title_period.upper()}", styles["MetaData"]))
    elements.append(
        Paragraph(
            f"Generated on {now.strftime('%B %d, %Y at %H:%M UTC')}", styles["MetaData"]
        )
    )
    elements.append(Spacer(1, 10))

    card_data = [
        [
            Paragraph("REVENUE", styles["CardLabel"]),
            Paragraph("RESERVATIONS", styles["CardLabel"]),
            Paragraph("UNIQUE SLOTS", styles["CardLabel"]),
        ],
        [
            Paragraph(f"LKR {total_revenue:,.0f}", styles["CardValue"]),
            Paragraph(str(total_count), styles["CardValue"]),
            Paragraph(str(unique_slots), styles["CardValue"]),
        ],
    ]

    kpi_table = Table(card_data, colWidths=[170, 170, 170])
    kpi_table.setStyle(
        TableStyle(
            [
                ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                ("TOPPADDING", (0, 0), (-1, -1), 10),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 10),
                ("BACKGROUND", (0, 0), (-1, -1), colors.HexColor("#F8F9FA")),
                ("BOX", (0, 0), (-1, -1), 0.5, colors.HexColor("#EEEEEE")),
                ("LINEBELOW", (0, 0), (-1, 0), 0.5, colors.HexColor("#EEEEEE")),
            ]
        )
    )
    elements.append(kpi_table)
    elements.append(Spacer(1, 30))

    elements.append(Paragraph("RESERVATION LOGS", styles["Heading3"]))
    elements.append(Spacer(1, 10))
    table_data = [["SLOT", "USER ID", "CHECK-IN", "CHECK-OUT", "REVENUE"]]

    for r in reservations:
        ci = r.get("check_in_time")
        co = r.get("check_out_time")
        ti = f"{ci.strftime('%m/%d %H:%M')}" if ci else "—"
        to = f"{co.strftime('%m/%d %H:%M')}" if co else "—"

        slot_val = str(r.get("slot_name") or r.get("slot_id") or "—").upper()
        if len(slot_val) > 12:
            slot_val = f"{slot_val[:6]}..{slot_val[-4:]}"

        user_val = str(r.get("user_id") or "Guest").upper()
        if "-" in user_val:
            user_val = user_val.split("-")[-1]
        if len(user_val) > 12:
            user_val = user_val[-8:]

        table_data.append(
            [
                slot_val,
                user_val,
                ti,
                to,
                f"LKR {r.get('total_billed_price', 0.0):.0f}",
            ]
        )

    if len(table_data) == 1:
        elements.append(
            Paragraph("No records found for this period.", styles["Italic"])
        )
    else:
        if len(table_data) > 500:
            table_data = table_data[:500]
            elements.append(Paragraph("(Showing first 500 records)", styles["Italic"]))

        detail_table = Table(
            table_data, colWidths=[80, 130, 110, 110, 85], repeatRows=1
        )

        table_style = TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#333233")),
                ("TEXTCOLOR", (0, 0), (-1, 0), colors.whitesmoke),
                ("ALIGN", (0, 0), (-1, 0), "CENTER"),
                ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
                ("FONTSIZE", (0, 0), (-1, 0), 10),
                ("BOTTOMPADDING", (0, 0), (-1, 0), 12),
                ("TOPPADDING", (0, 0), (-1, 0), 12),
                ("ALIGN", (0, 1), (-1, -1), "CENTER"),
                ("FONTSIZE", (0, 1), (-1, -1), 9),
                ("FONTNAME", (0, 1), (-1, -1), "Helvetica"),
                ("BOTTOMPADDING", (0, 1), (-1, -1), 8),
                ("TOPPADDING", (0, 1), (-1, -1), 8),
                ("TEXTCOLOR", (0, 1), (-1, -1), colors.HexColor("#444444")),
                ("LINEBELOW", (0, 0), (-1, -1), 0.5, colors.HexColor("#EEEEEE")),
            ]
        )

        for i in range(1, len(table_data)):
            if i % 2 == 0:
                table_style.add(
                    "BACKGROUND", (0, i), (-1, i), colors.HexColor("#F9F9F9")
                )

        detail_table.setStyle(table_style)
        elements.append(detail_table)

    elements.append(Spacer(1, 40))
    elements.append(
        Paragraph(
            "This is an automated system-generated report from ParkFlow AI Core.",
            styles["MetaData"],
        )
    )

    doc.build(elements)
    buffer.seek(0)

    filename = f"parkflow_report_{period}_{now.strftime('%Y%m%d')}.pdf"
    return StreamingResponse(
        buffer,
        media_type="application/pdf",
        headers={"Content-Disposition": f"attachment; filename={filename}"},
    )
