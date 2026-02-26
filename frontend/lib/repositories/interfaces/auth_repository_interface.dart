import 'package:parkflow/models/auth/user_model.dart';

abstract class AuthRepositoryInterface {
  Future<UserModel> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
  Future<String?> getToken();
  Future<UserModel?> getCurrentUser();
}
