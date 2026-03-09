import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/services/auth_service.dart';
import 'package:parkflow/core/network/entities/login_response_entity.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/core/network/entities/login_request_entity.dart';
import '../helpers/test_helpers.dart';

void main() {
  late AuthService authService;
  late MockRemoteRepository mockRemote;
  late MockSecureStorageRepository mockStorage;

  setUp(() {
    mockRemote = MockRemoteRepository();
    mockStorage = MockSecureStorageRepository();
    authService = AuthService(mockRemote, mockStorage);

    registerFallbackValue(LoginRequestEntity(email: '', password: ''));
  });

  group('AuthService', () {
    test('login should succeed and store tokens', () async {
      final loginResponse = LoginResponseEntity(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
        tokenType: 'Bearer',
        accessTokenExpiresAt: '2026-03-09T12:00:00Z',
        refreshTokenExpiresAt: '2026-03-10T12:00:00Z',
      );

      final userResponse = GetUserResponseEntity(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        role: 'user',
        vehicles: [],
        paymentMethods: [],
      );

      when(() => mockRemote.login(any())).thenAnswer((_) async => loginResponse);
      when(() => mockRemote.getCurrentUser(any()))
          .thenAnswer((_) async => userResponse);
      when(() => mockStorage.setAccessToken(any())).thenAnswer((_) async => {});
      when(() => mockStorage.setRefreshToken(any()))
          .thenAnswer((_) async => {});
      when(() => mockStorage.setAccessTokenExpiry(any()))
          .thenAnswer((_) async => {});
      when(() => mockStorage.setRefreshTokenExpiry(any()))
          .thenAnswer((_) async => {});

      final user = await authService.login('test@example.com', 'password');

      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      verify(() => mockRemote.login(any())).called(1);
      verify(() => mockStorage.setAccessToken('access_token')).called(1);
    });

    test('logout should clear storage', () async {
      when(() => mockStorage.clearAllAuthData()).thenAnswer((_) async => {});

      await authService.logout();

      verify(() => mockStorage.clearAllAuthData()).called(1);
    });
  });
}
