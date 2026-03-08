from fastapi_mail import ConnectionConfig, FastMail, MessageSchema, MessageType
from app.core.config import settings
from loguru import logger
from typing import List, Optional, Any


class EmailService:
    def __init__(self):
        self.conf = ConnectionConfig(
            MAIL_USERNAME=settings.MAIL_USERNAME,
            MAIL_PASSWORD=settings.MAIL_PASSWORD,
            MAIL_FROM=settings.MAIL_FROM,
            MAIL_PORT=settings.MAIL_PORT,
            MAIL_SERVER=settings.MAIL_SERVER,
            MAIL_STARTTLS=settings.MAIL_STARTTLS,
            MAIL_SSL_TLS=settings.MAIL_SSL_TLS,
            USE_CREDENTIALS=True,
            VALIDATE_CERTS=True,
        )
        self.fastmail = FastMail(self.conf)

    async def send_email(
        self,
        subject: str,
        recipients: List[str],
        body: str,
        subtype: MessageType = MessageType.html,
    ):
        message = MessageSchema(
            subject=subject, recipients=recipients, body=body, subtype=subtype
        )

        try:
            await self.fastmail.send_message(message)
            logger.info(f"Email sent successfully to {recipients}")
            return True
        except Exception as e:
            logger.error(f"Failed to send email to {recipients}: {e}")
            return False


email_service = EmailService()
