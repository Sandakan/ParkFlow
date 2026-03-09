import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/auth/vehicle_model.dart';

part 'create_reservation_request_entity.freezed.dart';
part 'create_reservation_request_entity.g.dart';

@freezed
abstract class CreateReservationRequestEntity
    with _$CreateReservationRequestEntity {
  const factory CreateReservationRequestEntity({
    @JsonKey(name: 'slot_id') required String slotId,
    @JsonKey(name: 'lot_id') String? lotId,
    required VehicleModel vehicle,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'payment_method') required String paymentMethod,
  }) = _CreateReservationRequestEntity;

  factory CreateReservationRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateReservationRequestEntityFromJson(json);
}
