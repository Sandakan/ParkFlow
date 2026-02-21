from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    PROJECT_NAME: str = "ParkFlow API"
    VERSION: str = "1.0.0"
    MONGODB_URL: str = "mongodb://localhost:27017/parkflow"
    REDIS_URL: str = "redis://redis:6379"

    class Config:
        env_file = ".env"


settings = Settings()
