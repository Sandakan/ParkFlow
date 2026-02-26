import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/services/auth_service.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    _checkInitialState();

    return const AuthState.loading();
  }

  Future<void> _checkInitialState() async {
    try {
      final user = await ref.read(authServiceProvider).checkAuthState();

      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await ref.read(authServiceProvider).login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = const AuthState.loading();
    try {
      await ref.read(authServiceProvider).register(name, email, password);
      // Auto-login after successful registration
      final user = await ref.read(authServiceProvider).login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();

    await ref.read(authServiceProvider).logout();

    state = const AuthState.unauthenticated();
  }
}
