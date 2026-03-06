import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_repository_provider.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

class AuthService {
  final RemoteRepositoryInterface _remote;
  final SecureStorageRepositoryInterface _storage;

  AuthService(this._remote, this._storage);

  Future<UserModel> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }

      final request = LoginRequestEntity(email: email, password: password);
      final response = await _remote.login(request);

      await _storage.setAccessToken(response.accessToken);
      await _storage.setRefreshToken(response.refreshToken);
      await _storage.setAccessTokenExpiry(response.accessTokenExpiresAt);
      await _storage.setRefreshTokenExpiry(response.refreshTokenExpiresAt);

      final userResponse = await _remote.getCurrentUser(response.accessToken);
      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }

      final request = RegisterRequestEntity(
        name: name,
        email: email,
        password: password,
      );
      await _remote.register(request);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> logout() async {
    await _storage.clearAllAuthData();
  }

  Future<UserModel?> checkAuthState() async {
    try {
      final token = await _storage.getAccessToken();
      if (token == null) return null;

      final userResponse = await _remote.getCurrentUser(token);
      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
        vehicles: userResponse.vehicles,
        paymentMethods: userResponse.paymentMethods,
      );
    } catch (e) {
      return null;
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  final storage = ref.watch(secureStorageRepositoryProvider);
  return AuthService(remote, storage);
});
