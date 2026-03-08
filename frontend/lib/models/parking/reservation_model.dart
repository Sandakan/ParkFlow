import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';

part 'reservation_model.freezed.dart';
part 'reservation_model.g.dart';

@freezed
abstract class ReservationModel with _$ReservationModel {
  const factory ReservationModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'slot_id') required String slotId,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    required VehicleModel vehicle,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'total_price') required double totalPrice,
    @JsonKey(name: 'base_rate') required double baseRate,
    @JsonKey(name: 'check_in_time') DateTime? checkInTime,
    @JsonKey(name: 'check_out_time') DateTime? checkOutTime,
    @JsonKey(name: 'actual_end_time') required DateTime actualEndTime,
    @JsonKey(name: 'total_billed_price') required double totalBilledPrice,
    required String status,
    @JsonKey(name: 'qr_code_token') required String qrCodeToken,
    @JsonKey(name: 'lot_name') required String lotName,
    @JsonKey(name: 'slot_name') required String slotName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ReservationModel;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);
}

enum ReservationStatus {
  upcoming,
  noShow,
  expired,
  ongoing,
  overstay,
  completed,
  cancelled,
}

extension ReservationModelX on ReservationModel {
  ReservationStatus get detailedStatus {
    final now = DateTime.now().toUtc();
    final start = startTime.toUtc();
    final end = endTime.toUtc();

    if (status.toLowerCase() == 'cancelled') {
      return ReservationStatus.cancelled;
    }
    if (status.toLowerCase() == 'completed') {
      return ReservationStatus.completed;
    }

    // Status is active
    if (checkInTime == null) {
      if (start.isAfter(now)) {
        return ReservationStatus.upcoming;
      } else if (now.isBefore(end)) {
        return ReservationStatus.upcoming;
      } else {
        return ReservationStatus.expired;
      }
    } else {
      // Checked in
      if (checkOutTime != null) {
        return ReservationStatus.completed;
      }

      if (now.isBefore(end)) {
        return ReservationStatus.ongoing;
      } else {
        return ReservationStatus.overstay;
      }
    }
  }
}
