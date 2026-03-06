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

  ReservationService(this._remoteRepository);

  Future<List<ReservationModel>> getMyReservations() async {
    return _remoteRepository.getMyReservations();
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

    return _remoteRepository.createReservation(request);
  }
}

@riverpod
ReservationService reservationService(Ref ref) {
  return ReservationService(ref.watch(remoteRepositoryProvider));
}
