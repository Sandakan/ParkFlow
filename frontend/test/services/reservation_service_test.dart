import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/services/reservation_service.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/repositories/entities/reservation/create_reservation_request_entity.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';
import 'package:parkflow/core/network/entities/reservation_response_entity.dart';
import 'package:parkflow/core/network/entities/slot_availability_response_entity.dart';
import '../helpers/test_helpers.dart';

void main() {
  late MockRemoteRepository mockRemoteRepository;
  late MockEnvRepository mockEnvRepository;
  late MockAuthNotifier mockAuthNotifier;
  late ProviderContainer container;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    mockEnvRepository = MockEnvRepository();
    mockAuthNotifier = MockAuthNotifier();

    when(() => mockEnvRepository.getBaseUrl()).thenReturn('http://api.test');

    container = ProviderContainer(
      overrides: [
        remoteRepositoryProvider.overrideWithValue(mockRemoteRepository),
        envRepositoryProvider.overrideWithValue(mockEnvRepository),
        authProvider.overrideWith(() => mockAuthNotifier),
      ],
    );

    registerFallbackValue(
      CreateReservationRequestEntity(
        slotId: '',
        vehicle: const VehicleModel(plateNumber: '', type: ''),
        startTime: '',
        durationMinutes: 0,
        paymentMethod: '',
      ),
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ReservationService', () {
    test(
      'getMyReservations should call remote repository with token',
      () async {
        when(
          () => mockAuthNotifier.getValidAccessToken(),
        ).thenAnswer((_) async => 'test_token');
        when(
          () =>
              mockRemoteRepository.getMyReservations(accessToken: 'test_token'),
        ).thenAnswer((_) async => []);

        final service = container.read(reservationServiceProvider);
        final result = await service.getMyReservations();

        expect(result, isEmpty);
        verify(
          () =>
              mockRemoteRepository.getMyReservations(accessToken: 'test_token'),
        ).called(1);
      },
    );

    test('createReservation should call remote repository', () async {
      when(
        () => mockAuthNotifier.getValidAccessToken(),
      ).thenAnswer((_) async => 'test_token');

      final startTime = DateTime(2023, 10, 10, 10, 0);
      const vehicle = VehicleModel(plateNumber: 'ABC-123', type: 'car');

      final reservation = ReservationModel(
        id: 'res_1',
        userId: 'user_1',
        slotId: 'slot_1',
        startTime: startTime,
        endTime: startTime.add(const Duration(minutes: 60)),
        vehicle: vehicle,
        durationMinutes: 60,
        paymentMethod: 'cash',
        totalPrice: 10.0,
        baseRate: 10.0,
        actualEndTime: startTime.add(const Duration(minutes: 60)),
        totalBilledPrice: 10.0,
        status: 'pending',
        qrCodeToken: 'qr_1',
        hasRating: false,
        lotName: 'Lot 1',
        lotAddress: 'Address 1',
        lotLatitude: 0.0,
        lotLongitude: 0.0,
        slotName: 'Slot A1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final response = ReservationResponseEntity(reservation: reservation);

      when(
        () => mockRemoteRepository.createReservation(
          any(),
          accessToken: 'test_token',
        ),
      ).thenAnswer((_) async => response);

      final service = container.read(reservationServiceProvider);
      final result = await service.createReservation(
        slotId: 'slot_1',
        vehicle: vehicle,
        startTime: startTime,
        durationMinutes: 60,
        paymentMethod: 'cash',
      );

      expect(result.reservation.id, 'res_1');
      verify(
        () => mockRemoteRepository.createReservation(
          any(that: isA<CreateReservationRequestEntity>()),
          accessToken: 'test_token',
        ),
      ).called(1);
    });

    test('checkSlotAvailability should call remote repository', () async {
      when(
        () => mockAuthNotifier.getValidAccessToken(),
      ).thenAnswer((_) async => 'test_token');

      final startTime = DateTime(2023, 10, 10, 10, 0);
      const response = SlotAvailabilityResponseEntity(
        available: true,
        slotId: 'slot_1',
      );

      when(
        () => mockRemoteRepository.checkSlotAvailability(
          any(),
          startTime: any(named: 'startTime'),
          durationMinutes: any(named: 'durationMinutes'),
          accessToken: any(named: 'accessToken'),
        ),
      ).thenAnswer((_) async => response);

      final service = container.read(reservationServiceProvider);
      final result = await service.checkSlotAvailability(
        slotId: 'slot_1',
        startTime: startTime,
        durationMinutes: 30,
      );

      expect(result.available, isTrue);
      verify(
        () => mockRemoteRepository.checkSlotAvailability(
          'slot_1',
          startTime: startTime,
          durationMinutes: 30,
          accessToken: 'test_token',
        ),
      ).called(1);
    });
  });
}
