from typing import Optional, Any, Literal
from datetime import datetime, timezone
import json
from app.core.database import db
from app.core.redis import redis_cache
from app.models.notification import NotificationInDB
from loguru import logger
from app.repositories.user_repository import user_repository
from app.services.email_service import email_service


class NotificationService:
    @staticmethod
    async def send_notification(
        title: str,
        message: str,
        user_id: Optional[str] = None,
        notification_type: Literal["info", "success", "warning", "error"] = "info",
        payload: Optional[dict[str, Any]] = None,
    ):
        """
        Create a notification in DB and publish to Redis for SSE.
        """
        notification = NotificationInDB(
            user_id=user_id,
            title=title,
            message=message,
            type=notification_type,
            payload=payload or {},
        )

        notification_dict = notification.model_dump(by_alias=True)
        await db.client["parkflow"].notifications.insert_one(notification_dict)

        try:
            notification_dict["_id"] = str(notification_dict["_id"])
            if isinstance(notification_dict.get("created_at"), datetime):
                notification_dict["created_at"] = notification_dict[
                    "created_at"
                ].isoformat()

            await redis_cache.client.publish(
                "notification_updates", json.dumps(notification_dict)
            )
        except Exception as e:
            logger.error(f"Failed to publish notification: {e}")

        if user_id:
            try:
                user = await user_repository.get_by_id(user_id)
                if user and user.email:
                    email_body = f"""
                    <!DOCTYPE html>
                    <html>
                    <body style="font-family: 'Poppins', 'Inter', Arial, sans-serif;">
                        <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 16px; overflow: hidden;  border: 2px solid #ecf0f1;">
                            <div style="padding: 40px;">
                                <img src="https://github.com/Sandakan/ParkFlow/blob/main/frontend/assets/images/logo_white.png?raw=true" alt="ParkFlow Logo" style="height: 40px;">
                            </div>
                            <div style="padding: 40px; color: #334155;">
                                <h1 style="font-size: 24px; color: #0f172a; margin-top: 0; font-weight: 600;">{title}</h1>
                                <p style="font-size: 16px; line-height: 1.6; color: #475569; margin-bottom: 30px;">{message}</p>
                            </div>
                            <div style="background-color: #f8fafc; padding: 20px; text-align: center; font-size: 12px; color: #94a3b8;">
                                &copy; 2024 ParkFlow.
                            </div>
                        </div>
                    </body>
                    </html>
                    """
                    email_service.send_email(
                        subject=f"ParkFlow: {title}",
                        recipients=[user.email],
                        body=email_body,
                    )
            except Exception as e:
                logger.error(f"Failed to send notification email: {e}")

        return notification


notification_service = NotificationService()
