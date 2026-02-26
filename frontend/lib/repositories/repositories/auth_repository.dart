import 'package:parkflow/repositories/interfaces/auth_repository_interface.dart';
import 'package:parkflow/repositories/interfaces/secure_storage_repository_interface.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import 'package:parkflow/core/network/entities/register_request_entity.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

class AuthRepository implements AuthRepositoryInterface {
  final RemoteRepositoryInterface remote;
  final SecureStorageRepositoryInterface storage;

  AuthRepository({required this.remote, required this.storage});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final request = LoginRequestEntity(username: email, password: password);
      final response = await remote.login(request);
      final token = response.accessToken;

      await storage.write(key: 'access_token', value: token);

      final userResponse = await remote.getCurrentUser(token);
      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      final request = RegisterRequestEntity(
        name: name,
        email: email,
        password: password,
      );
      await remote.register(request);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'access_token');
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final token = await storage.read(key: 'access_token');
      if (token == null) return null;

      final userResponse = await remote.getCurrentUser(token);
      return UserModel(
        id: userResponse.id,
        email: userResponse.email,
        name: userResponse.name,
        role: userResponse.role,
      );
    } catch (e) {
      return null;
    }
  }
}
