import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/repositories/providers/auth_repository_provider.dart';
import 'package:parkflow/repositories/interfaces/auth_repository_interface.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

class AuthService {
  final AuthRepositoryInterface _authRepo;

  AuthService(this._authRepo);

  Future<UserModel> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      return await _authRepo.login(email, password);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw const AppException(AppStatusCode.invalidResponse);
      }
      await _authRepo.register(name, email, password);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
  }

  Future<UserModel?> checkAuthState() async {
    return await _authRepo.getCurrentUser();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthService(repo);
});
