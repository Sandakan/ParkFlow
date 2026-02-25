import 'package:parkflow/utils/constants/enums/language.dart';

abstract class SecureStorageRepositoryInterface {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> setAccessToken(String accessToken);
  Future<void> setRefreshToken(String refreshToken);
  Future<void> logout();
  Future<void> setAccessTokenExpiry(int seconds);
  Future<void> setRefreshTokenExpiry(int milliseconds);
  Future<int?> getRefreshTokenExpiry();
  Future<bool> isAccessTokenExpired();
  Future<bool> isRefreshTokenExpired();
  Future<LanguageEnum?> getLocale();
  Future<void> setLocale(LanguageEnum language);
  Future<void> setUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearAccessToken();
  Future<void> clearRefreshToken();
  Future<void> clearAccessTokenExpiry();
  Future<void> clearRefreshTokenExpiry();
  Future<void> clearUserId();
  Future<void> clearAllAuthData();

  Future<void> write({required String key, required String value});
  Future<String?> read({required String key});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}
