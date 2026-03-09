import pytest
from datetime import timedelta
from jose import jwt
from app.core.security import verify_password, get_password_hash, create_access_token, create_refresh_token
from app.core.config import settings

def test_password_hashing():
    password = "secret_password"
    hashed = get_password_hash(password)
    assert hashed != password
    assert verify_password(password, hashed) is True
    assert verify_password("wrong_password", hashed) is False

def test_create_access_token():
    subject = "user123"
    token = create_access_token(subject)
    decoded = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
    assert decoded["sub"] == subject
    assert "exp" in decoded

def test_create_access_token_expires_delta():
    subject = "user456"
    expires_delta = timedelta(minutes=10)
    token = create_access_token(subject, expires_delta=expires_delta)
    decoded = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
    assert decoded["sub"] == subject

def test_create_refresh_token():
    subject = "user789"
    token = create_refresh_token(subject)
    decoded = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
    assert decoded["sub"] == subject
    assert "exp" in decoded
