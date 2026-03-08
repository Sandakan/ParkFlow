import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/services/auth_service.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/secure_storage_provider.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  Future<String?>? _refreshOperation;

  @override
  AuthState build() {
    _initAuthStatus();
    return const AuthState.initial();
  }

  Future<void> _initAuthStatus() async {
    state = const AuthState.loading();
    try {
      final storage = ref.read(secureStorageRepositoryProvider);
      final remoteRepo = ref.read(remoteRepositoryProvider);

      final accessToken = await storage.getAccessToken();
      final refreshToken = await storage.getRefreshToken();

      // 1. If no access token, user is unauthenticated
      if (accessToken == null) {
        state = const AuthState.unauthenticated();
        return;
      }

      // 2. Check if access token is locally expired
      final isAccessTokenExpired = await storage.isAccessTokenExpired();
      String currentTokenToTest = accessToken;

      // 3. If access token is locally expired, attempt to refresh
      if (isAccessTokenExpired) {
        if (refreshToken == null) {
          state = const AuthState.unauthenticated();
          return;
        }

        final isRefreshTokenExpired = await storage.isRefreshTokenExpired();
        if (isRefreshTokenExpired) {
          await storage.clearAllAuthData();
          state = const AuthState.unauthenticated();
          return;
        }

        // Token refresh attempt
        try {
          final refreshResponse = await remoteRepo.refreshToken(refreshToken);
          await storage.setAccessToken(refreshResponse.accessToken);
          await storage.setRefreshToken(refreshResponse.refreshToken);
          await storage.setAccessTokenExpiry(
            refreshResponse.accessTokenExpiresAt,
          );
          await storage.setRefreshTokenExpiry(
            refreshResponse.refreshTokenExpiresAt,
          );

          currentTokenToTest = refreshResponse.accessToken;
        } catch (e) {
          await storage.clearAllAuthData();
          state = const AuthState.unauthenticated();
          return;
        }
      }

      // 4. Test the token by calling the backend
      try {
        final userResponse = await remoteRepo.testToken(currentTokenToTest);

        final user = UserModel(
          id: userResponse.id,
          email: userResponse.email,
          name: userResponse.name,
          role: userResponse.role,
          vehicles: userResponse.vehicles,
          paymentMethods: userResponse.paymentMethods,
        );

        state = AuthState.authenticated(user);
      } catch (e) {
        await storage.clearAllAuthData();
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
    }
  }

  /// Returns a valid access token, refreshing it if necessary.
  ///
  /// If a refresh is already in progress (e.g. from a parallel request),
  /// this will await the existing refresh future instead of starting a new one.
  Future<String?> getValidAccessToken() async {
    final storage = ref.read(secureStorageRepositoryProvider);

    final isExpired = await storage.isAccessTokenExpired();

    if (!isExpired) {
      talker.info('✅ [Auth] Access token is valid');
      return storage.getAccessToken();
    }

    talker.warning('⚠️  [Auth] Access token expired, refreshing...');

    if (_refreshOperation != null) {
      talker.info('⏳ [Auth] Awaiting existing refresh operation...');
      return _refreshOperation;
    }
    _refreshOperation = _performTokenRefresh();
    try {
      final token = await _refreshOperation;
      talker.info('✅ [Auth] Token refreshed successfully');
      return token;
    } finally {
      _refreshOperation = null;
      talker.debug('🔓 [Auth] Refresh lock released');
    }
  }

  Future<String?> _performTokenRefresh() async {
    final storage = ref.read(secureStorageRepositoryProvider);
    final remoteRepo = ref.read(remoteRepositoryProvider);

    final refreshToken = await storage.getRefreshToken();

    if (refreshToken == null) {
      await _forceLogout();
      throw const AppException(AppStatusCode.authTokenExpired);
    }

    final isRefreshExpired = await storage.isRefreshTokenExpired();
    if (isRefreshExpired) {
      await _forceLogout();
      throw const AppException(AppStatusCode.authTokenExpired);
    }

    try {
      final refreshResponse = await remoteRepo.refreshToken(refreshToken);
      await storage.setAccessToken(refreshResponse.accessToken);
      await storage.setRefreshToken(refreshResponse.refreshToken);
      await storage.setAccessTokenExpiry(refreshResponse.accessTokenExpiresAt);
      await storage.setRefreshTokenExpiry(
        refreshResponse.refreshTokenExpiresAt,
      );
      return refreshResponse.accessToken;
    } catch (e) {
      talker.error('🚨 [Auth] Token refresh failed: $e');
      await _forceLogout();
      throw const AppException(AppStatusCode.authTokenExpired);
    }
  }

  Future<void> _forceLogout() async {
    await ref.read(secureStorageRepositoryProvider).clearAllAuthData();
    state = const AuthState.unauthenticated();
  }

  void setAuthenticatedUser(UserModel user) {
    state = AuthState.authenticated(user);
  }

  void setUnauthenticated() {
    state = const AuthState.unauthenticated();
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

  Future<void> forgotPassword(String email) async {
    state = const AuthState.loading();
    try {
      await ref.read(authServiceProvider).forgotPassword(email);
      state = const AuthState.unauthenticated(); // Or keep it as is, we just need to handle navigation in UI
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
      rethrow;
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const AuthState.loading();
    try {
      await ref.read(authServiceProvider).verifyOtp(email, otp);
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
      rethrow;
    }
  }

  Future<void> resetPassword(String email, String otp, String password) async {
    state = const AuthState.loading();
    try {
      await ref.read(authServiceProvider).resetPassword(email, otp, password);
      // After successful reset, we can redirect back to login
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(ErrorHandler.handle(e));
      rethrow;
    }
  }

  void clearError() {
    if (state is AuthError) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> refreshUser() async {
    try {
      final user = await ref.read(authServiceProvider).checkAuthState();
      if (user != null) {
        setAuthenticatedUser(user);
      } else {
        talker.warning('[Auth] refreshUser: checkAuthState returned null');
      }
    } catch (e, stackTrace) {
      talker.error('[Auth] Refresh user failed', e, stackTrace);
    }
  }
}
