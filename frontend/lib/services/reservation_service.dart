import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/repositories/entities/reservation/create_reservation_request_entity.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';
import 'package:parkflow/core/network/entities/reservation_response_entity.dart';

part 'reservation_service.g.dart';

class ReservationService {
  final RemoteRepositoryInterface _remoteRepository;
  final Ref _ref;

  ReservationService(this._remoteRepository, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<List<ReservationModel>> getMyReservations() async {
    return _remoteRepository.getMyReservations(accessToken: await _getToken());
  }

  Future<ReservationResponseEntity> createReservation({
    required String slotId,
    String? lotId,
    required VehicleModel vehicle,
    required DateTime startTime,
    required int durationMinutes,
    required String paymentMethod,
  }) async {
    final request = CreateReservationRequestEntity(
      slotId: slotId,
      lotId: lotId,
      vehicle: vehicle,
      startTime: startTime.toIso8601String(),
      durationMinutes: durationMinutes,
      paymentMethod: paymentMethod,
    );

    return _remoteRepository.createReservation(
      request,
      accessToken: await _getToken(),
    );
  }
}

@riverpod
ReservationService reservationService(Ref ref) {
  return ReservationService(ref.watch(remoteRepositoryProvider), ref);
}
