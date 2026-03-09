import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/core/network/entities/get_parking_lots_response_entity.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/states/auth/auth_state.dart';
import '../helpers/test_helpers.dart';

// We mock the notifier by subclassing Notifier to satisfy Riverpod internal constraints.
class MockAuthNotifier extends Notifier<AuthState> with Mock implements AuthNotifier {
  @override
  AuthState build() => const AuthState.initial();
}

void main() {
  late MockRemoteRepository mockRemote;
  late MockAuthNotifier mockAuthNotifier;
  late MockEnvRepository mockEnv;
  late ProviderContainer container;
  late ParkingService parkingService;

  setUp(() {
    mockRemote = MockRemoteRepository();
    mockAuthNotifier = MockAuthNotifier();
    mockEnv = MockEnvRepository();
    
    when(() => mockEnv.getBaseUrl()).thenReturn('http://api.test');
    when(() => mockAuthNotifier.getValidAccessToken())
        .thenAnswer((_) async => 'fake_token');

    container = ProviderContainer(
      overrides: [
        remoteRepositoryProvider.overrideWithValue(mockRemote),
        envRepositoryProvider.overrideWithValue(mockEnv),
        authProvider.overrideWith(() => mockAuthNotifier),
      ],
    );

    parkingService = container.read(parkingServiceProvider);
  });

  tearDown(() {
    container.dispose();
  });

  group('ParkingService', () {
    test('fetchParkingLots should return a list of lots', () async {
      const response = GetParkingLotsResponseEntity(lots: []);

      when(() => mockRemote.getParkingLots(
            accessToken: any(named: 'accessToken'),
          )).thenAnswer((_) async => response);

      final result = await parkingService.fetchParkingLots();

      expect(result, isEmpty);
      verify(() => mockRemote.getParkingLots(accessToken: 'fake_token')).called(1);
    });

    test('getParkingSuggestions should call remote repository', () async {
      when(() => mockRemote.getParkingSuggestions(
            any(),
            accessToken: any(named: 'accessToken'),
          )).thenThrow(Exception('API Error'));

      expect(
        () => parkingService.getParkingSuggestions('1'),
        throwsA(anything),
      );
    });
  });
}
