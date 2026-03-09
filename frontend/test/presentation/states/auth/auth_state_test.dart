import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';

void main() {
  group('AuthState', () {
    const user = UserModel(
      id: '1',
      email: 'test@test.com',
      name: 'Test',
      role: 'admin',
    );

    test('initial state should be Initial', () {
      const state = AuthState.initial();
      expect(state, isA<Initial>());
      expect(state.isAuthenticated, isFalse);
      expect(state.isLoading, isFalse);
    });

    test('loading state should detect correctly', () {
      const state = AuthState.loading();
      expect(state.isLoading, isTrue);
      expect(state.isAuthenticated, isFalse);
    });

    test('authenticated state should have user and correct role flags', () {
      const state = AuthState.authenticated(user);
      expect(state.isAuthenticated, isTrue);
      expect(state.user, user);
      expect(state.isAdmin, isTrue);
      expect(state.isDriver, isFalse);
    });

    test('unauthenticated state should be clean', () {
      const state = AuthState.unauthenticated();
      expect(state.isAuthenticated, isFalse);
      expect(state.user, isNull);
    });

    test('error state should contain exception', () {
      const exception = AppException(AppStatusCode.unknownError);
      const state = AuthState.error(exception);
      expect(state.error, exception);
    });
    
    test('driver role should be detected correctly', () {
      const driver = UserModel(
        id: '2',
        email: 'driver@test.com',
        name: 'Driver',
        role: 'driver',
      );
      const state = AuthState.authenticated(driver);
      expect(state.isAdmin, isFalse);
      expect(state.isDriver, isTrue);
    });
  });
}
