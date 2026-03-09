import pytest
from unittest.mock import patch, AsyncMock, MagicMock
from bson import ObjectId
from app.repositories.user_repository import user_repository
from app.models.user import UserInDB
from datetime import datetime, timezone

@pytest.mark.asyncio
async def test_get_by_email():
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_users_collection = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.__getitem__.return_value = mock_users_collection
        
        mock_user_doc = {
            "_id": ObjectId(),
            "name": "Test User",
            "email": "test@example.com",
            "password_hash": "hash",
            "role": "driver",
            "deleted_at": None
        }
        mock_users_collection.find_one = AsyncMock(return_value=mock_user_doc)
        
        result = await user_repository.get_by_email("test@example.com")
        assert result.email == "test@example.com"
        assert result.user_id == str(mock_user_doc["_id"])
        mock_users_collection.find_one.assert_called_once()

@pytest.mark.asyncio
async def test_get_by_id_success():
    user_id = str(ObjectId())
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_users_collection = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.__getitem__.return_value = mock_users_collection
        
        mock_user_doc = {
            "_id": ObjectId(user_id),
            "name": "Test User",
            "email": "test@example.com",
            "password_hash": "hash",
            "role": "driver",
            "deleted_at": None
        }
        mock_users_collection.find_one = AsyncMock(return_value=mock_user_doc)
        
        result = await user_repository.get_by_id(user_id)
        assert result.user_id == user_id
        mock_users_collection.find_one.assert_called_once()

@pytest.mark.asyncio
async def test_create_user():
    user_data = UserInDB(
        _id=str(ObjectId()),
        name="New User",
        email="new@example.com",
        password_hash="hash",
        role="driver"
    )
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_users_collection = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.__getitem__.return_value = mock_users_collection
        
        mock_result = MagicMock()
        mock_result.inserted_id = ObjectId()
        mock_users_collection.insert_one = AsyncMock(return_value=mock_result)
        
        result = await user_repository.create(user_data)
        assert result.user_id == str(mock_result.inserted_id)
        assert isinstance(result.created_at, datetime)
        mock_users_collection.insert_one.assert_called_once()

@pytest.mark.asyncio
async def test_update_user():
    user_id = str(ObjectId())
    update_data = {"name": "Updated Name"}
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_users_collection = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.__getitem__.return_value = mock_users_collection
        
        mock_user_doc = {
            "_id": ObjectId(user_id),
            "name": "Updated Name",
            "email": "test@example.com",
            "password_hash": "hash",
            "role": "driver",
            "deleted_at": None
        }
        mock_users_collection.find_one_and_update = AsyncMock(return_value=mock_user_doc)
        
        result = await user_repository.update(user_id, update_data)
        assert result.name == "Updated Name"
        mock_users_collection.find_one_and_update.assert_called_once()

@pytest.mark.asyncio
async def test_delete_user():
    user_id = str(ObjectId())
    with patch("app.core.database.db.client") as mock_client:
        mock_db = MagicMock()
        mock_users_collection = MagicMock()
        mock_client.__getitem__.return_value = mock_db
        mock_db.__getitem__.return_value = mock_users_collection
        
        mock_result = MagicMock()
        mock_result.matched_count = 1
        mock_users_collection.update_one = AsyncMock(return_value=mock_result)
        
        result = await user_repository.delete(user_id)
        assert result is True
        mock_users_collection.update_one.assert_called_once()
