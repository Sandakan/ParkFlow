import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/utils/constants/enums/language.dart';
import 'package:parkflow/utils/helpers/talker.dart';

class SecureStorageRepository implements SecureStorageRepositoryInterface {
  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';
  static const String _accessTokenExpiry = 'access_token_expiry';
  static const String _refreshTokenExpiry = 'refresh_token_expiry';
  static const String _localeKey = 'localeKey';
  static const String _userIdKey = 'userIdKey';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: true),
    iOptions: IOSOptions(synchronizable: true),
    webOptions: WebOptions(),
  );

  SecureStorageRepository();

  // Generic methods for backward compatibility
  @override
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _accessToken);
    } catch (e, stackTrace) {
      talker.error('Get Access Token failed', e, stackTrace);
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshToken);
    } catch (e, stackTrace) {
      talker.error('Get Refresh Token failed', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    try {
      await _secureStorage.write(key: _accessToken, value: accessToken);
    } catch (e, stackTrace) {
      talker.error('Set Access Token failed', e, stackTrace);
    }
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(key: _refreshToken, value: refreshToken);
    } catch (e, stackTrace) {
      talker.error('Set Refresh Token failed', e, stackTrace);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: _accessToken);
      await _secureStorage.delete(key: _refreshToken);
      await _secureStorage.delete(key: _localeKey);
      await _secureStorage.delete(key: _accessTokenExpiry);
    } catch (e, stackTrace) {
      talker.error('Logout failed', e, stackTrace);
    }
  }

  @override
  Future<void> setAccessTokenExpiry(int seconds) async {
    try {
      await _secureStorage.write(
        key: _accessTokenExpiry,
        value: seconds.toString(),
      );
    } catch (e, stackTrace) {
      talker.error('Set Access Token Expiry failed', e, stackTrace);
    }
  }

  @override
  Future<void> setRefreshTokenExpiry(int milliseconds) async {
    try {
      await _secureStorage.write(
        key: _refreshTokenExpiry,
        value: milliseconds.toString(),
      );
    } catch (e, stackTrace) {
      talker.error('Set Refresh Token Expiry Date failed', e, stackTrace);
    }
  }

  @override
  Future<int?> getRefreshTokenExpiry() async {
    try {
      final String? expiryDate = await _secureStorage.read(
        key: _refreshTokenExpiry,
      );
      return expiryDate != null ? int.parse(expiryDate) : null;
    } catch (e, stackTrace) {
      talker.error('Get Refresh Token Expiry Date failed', e, stackTrace);
      return null;
    }
  }

  @override
  Future<bool> isAccessTokenExpired() async {
    try {
      final String? expire = await _secureStorage.read(key: _accessTokenExpiry);

      if (expire == null) {
        talker.info(
          '🔑 [SecureStorage] Access token expiry not found, considering expired',
        );
        return true;
      }

      final expiryTime = int.parse(expire);
      final now = DateTime.now().millisecondsSinceEpoch;
      final isExpired = expiryTime < now;
      talker.info(
        '🔑 [SecureStorage] Access token expired: $isExpired (expiry: ${DateTime.fromMillisecondsSinceEpoch(expiryTime)}, now: ${DateTime.fromMillisecondsSinceEpoch(now)})',
      );
      return isExpired;
    } catch (e, stackTrace) {
      talker.error('Failed to check if access token expired', e, stackTrace);
      return false;
    }
  }

  @override
  Future<bool> isRefreshTokenExpired() async {
    try {
      final String? expire = await _secureStorage.read(
        key: _refreshTokenExpiry,
      );

      if (expire == null) {
        talker.info(
          '🔑 [SecureStorage] Refresh token expiry not found, considering expired',
        );
        return true;
      }

      final expiryTime = int.parse(expire);
      final now = DateTime.now().millisecondsSinceEpoch;
      final isExpired = expiryTime < now;
      talker.info(
        '🔑 [SecureStorage] Refresh token expired: $isExpired (expiry: ${DateTime.fromMillisecondsSinceEpoch(expiryTime)}, now: ${DateTime.fromMillisecondsSinceEpoch(now)})',
      );
      return isExpired;
    } catch (e, stackTrace) {
      talker.error('Failed to check if refresh token expired', e, stackTrace);
      return false;
    }
  }

  @override
  Future<LanguageEnum?> getLocale() async {
    try {
      final String? locale = await _secureStorage.read(key: _localeKey);
      if (locale != null) {
        return LanguageEnum.fromValue(locale);
      }
      return null;
    } catch (e, stackTrace) {
      talker.error('Get Locale failed', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> setLocale(LanguageEnum language) async {
    try {
      await _secureStorage.write(key: _localeKey, value: language.value);
    } catch (e, stackTrace) {
      talker.error('Set Locale failed', e, stackTrace);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      await _secureStorage.write(key: _userIdKey, value: userId);
    } catch (e, stackTrace) {
      talker.error('Set User ID failed', e, stackTrace);
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      return await _secureStorage.read(key: _userIdKey);
    } catch (e, stackTrace) {
      talker.error('Get User ID failed', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> clearAccessToken() async {
    await _secureStorage.delete(key: _accessToken);
  }

  @override
  Future<void> clearRefreshToken() async {
    await _secureStorage.delete(key: _refreshToken);
  }

  @override
  Future<void> clearAccessTokenExpiry() async {
    await _secureStorage.delete(key: _accessTokenExpiry);
  }

  @override
  Future<void> clearRefreshTokenExpiry() async {
    await _secureStorage.delete(key: _refreshTokenExpiry);
  }

  @override
  Future<void> clearUserId() async {
    await _secureStorage.delete(key: _userIdKey);
  }

  @override
  Future<void> clearAllAuthData() async {
    await clearAccessToken();
    await clearRefreshToken();
    await clearAccessTokenExpiry();
    await clearRefreshTokenExpiry();
    await clearUserId();
  }
}
