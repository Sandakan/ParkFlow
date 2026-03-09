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

    def _get_base_template(self, title: str, content: str) -> str:
        return f"""
        <!DOCTYPE html>
        <html>
        <head>
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
            <style>
                body {{
                    font-family: 'Poppins', sans-serif;
                    background-color: #f1f5f9;
                    margin: 0;
                    padding: 40px 20px;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #ffffff;
                    border-radius: 20px;
                    overflow: hidden;
                    border: 2px solid #e2e8f0;
                }}
                .header {{
                    padding: 40px 30px 20px;
                }}
                .content {{
                    padding: 10px 30px 40px;
                    color: #334155;
                }}
                .title {{
                    font-size: 24px;
                    color: #0f172a;
                    margin-top: 0;
                    font-weight: 700;
                    margin-bottom: 20px;
                }}
                .message {{
                    font-size: 16px;
                    line-height: 1.6;
                    color: #475569;
                    margin-bottom: 0;
                }}
                .footer {{
                    background-color: #f8fafc;
                    padding: 20px;
                    text-align: center;
                    font-size: 12px;
                    color: #94a3b8;
                    border-top: 1px solid #f1f5f9;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <img src="https://github.com/Sandakan/ParkFlow/blob/main/frontend/assets/images/logo_white.png?raw=true" alt="ParkFlow Logo" style="height: 32px;">
                </div>
                <div class="content">
                    <h1 class="title">{title}</h1>
                    <div class="message">{content}</div>
                </div>
                <div class="footer">
                    &copy; 2026 ParkFlow.
                </div>
            </div>
        </body>
        </html>
        """

    async def send_templated_email(
        self,
        subject: str,
        recipients: List[str],
        title: str,
        content: str,
    ):
        body = self._get_base_template(title, content)
        return await self.send_email(subject, recipients, body)


email_service = EmailService()
