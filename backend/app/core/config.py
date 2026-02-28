from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    PROJECT_NAME: str = "ParkFlow API"
    VERSION: str = "1.0.0"
    MONGODB_URL: str = "mongodb://localhost:27017/parkflow"
    REDIS_URL: str = "redis://redis:6379"
    SECRET_KEY: str = "your-super-secret-key-change-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days

    # AI Model Settings
    YOLO_MODEL_PATH: str = "/app/ai/models/best.pt"
    YOLO_CONFIDENCE: float = 0.25

    class Config:
        env_file = ".env"


settings = Settings()
