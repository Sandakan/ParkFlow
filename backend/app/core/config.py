from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    PROJECT_NAME: str = "ParkFlow API"
    VERSION: str = "1.1.0"
    MONGODB_URL: str = "mongodb://localhost:27017/parkflow"
    REDIS_URL: str = "redis://redis:6379"
    SECRET_KEY: str = "your-super-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days

    # AI Model Settings
    YOLO_MODEL_PATH: str = "/app/ai/models/best.pt"
    YOLO_CONFIDENCE: float = 0.1

    # Email Settings
    MAIL_USERNAME: str = "user@example.com"
    MAIL_PASSWORD: str = "password"
    MAIL_FROM: str = "user@example.com"
    MAIL_PORT: int = 587
    MAIL_SERVER: str = "smtp.ethereal.email"
    MAIL_STARTTLS: bool = True
    MAIL_SSL_TLS: bool = False

    model_config = SettingsConfigDict(env_file=".env")


settings = Settings()
