import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/reservation_model.dart';

part 'reservation_response_entity.freezed.dart';
part 'reservation_response_entity.g.dart';

@freezed
abstract class ReservationResponseEntity with _$ReservationResponseEntity {
  const factory ReservationResponseEntity({
    required ReservationModel reservation,
  }) = _ReservationResponseEntity;

  factory ReservationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseEntityFromJson({'reservation': json});
}
