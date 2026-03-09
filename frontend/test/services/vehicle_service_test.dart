import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/services/vehicle_service.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/core/network/entities/get_user_response_entity.dart';
import 'package:parkflow/utils/constants/enums/app_status_code.dart';
import '../helpers/test_helpers.dart';

void main() {
  late MockRemoteRepository mockRemoteRepository;
  late MockAuthNotifier mockAuthNotifier;
  late ProviderContainer container;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    mockAuthNotifier = MockAuthNotifier();

    container = ProviderContainer(
      overrides: [
        remoteRepositoryProvider.overrideWithValue(mockRemoteRepository),
        authProvider.overrideWith(() => mockAuthNotifier),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('VehicleService', () {
    const mockUser = GetUserResponseEntity(
      id: 'user_123',
      email: 'test@example.com',
      name: 'Test User',
      role: 'user',
      vehicles: [],
      paymentMethods: [],
    );

    test('addVehicle should call remote repository with correct data', () async {
      when(() => mockAuthNotifier.getValidAccessToken())
          .thenAnswer((_) async => 'test_token');
      
      when(() => mockRemoteRepository.addVehicle(any(), accessToken: 'test_token'))
          .thenAnswer((_) async => mockUser);

      final service = container.read(vehicleServiceProvider);
      await service.addVehicle('ABC-1234', 'car');

      verify(() => mockRemoteRepository.addVehicle(
            {'plate_number': 'ABC-1234', 'type': 'car'},
            accessToken: 'test_token',
          )).called(1);
    });

    test('addVehicle should throw exception if input is empty', () async {
      final service = container.read(vehicleServiceProvider);
      
      expect(
        () => service.addVehicle('', 'car'),
        throwsA(isA<AppException>().having((e) => e.code, 'code', AppStatusCode.invalidResponse)),
      );
    });

    test('removeVehicle should call remote repository', () async {
      when(() => mockAuthNotifier.getValidAccessToken())
          .thenAnswer((_) async => 'test_token');
      
      when(() => mockRemoteRepository.removeVehicle('ABC-1234', accessToken: 'test_token'))
          .thenAnswer((_) async => mockUser);

      final service = container.read(vehicleServiceProvider);
      await service.removeVehicle('ABC-1234');

      verify(() => mockRemoteRepository.removeVehicle('ABC-1234', accessToken: 'test_token'))
          .called(1);
    });
  });
}
