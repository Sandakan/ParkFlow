from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine, text
from os import getenv

app = FastAPI(title="ParkFlow API", version="1.0.0")

# CORS (Allow Flutter to talk to Backend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Database configuration
DATABASE_URL = getenv("DATABASE_URL")


def check_database_connection():
    """Check if the database is connected and return the status."""

    if not DATABASE_URL:
        raise ValueError("DATABASE_URL environment variable is not set")
    else:
        print("DATABASE_URL found in environment variables.")

    try:
        engine = create_engine(DATABASE_URL)
        with engine.connect() as connection:
            connection.execute(text("SELECT 1"))
        return {"connected": True, "status": "Database connection successful"}
    except Exception as e:
        return {"connected": False, "status": f"Database connection failed: {str(e)}"}


@app.get("/")
def read_root():
    db_status = check_database_connection()
    return {"message": "Welcome to ParkFlow AI Core", "database": db_status}
