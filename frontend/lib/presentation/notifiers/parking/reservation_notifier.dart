import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';
import 'package:parkflow/services/reservation_service.dart';

part 'reservation_notifier.g.dart';

@Riverpod(name: 'reservationNotifierProvider')
class ReservationNotifier extends _$ReservationNotifier {
  @override
  Stream<List<ReservationModel>> build() {
    return ref.watch(reservationServiceProvider).streamMyReservations();
  }

  Future<ReservationModel?> createReservation({
    required String slotId,
    String? lotId,
    required VehicleModel vehicle,
    required DateTime startTime,
    required int durationMinutes,
    required String paymentMethod,
  }) async {
    state = const AsyncLoading();
    try {
      final response = await ref
          .read(reservationServiceProvider)
          .createReservation(
            slotId: slotId,
            lotId: lotId,
            vehicle: vehicle,
            startTime: startTime,
            durationMinutes: durationMinutes,
            paymentMethod: paymentMethod,
          );

      ref.invalidateSelf();
      return response.reservation;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return null;
    }
  }
}
