import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/reservation_model.dart';

part 'get_reservations_response_entity.freezed.dart';
part 'get_reservations_response_entity.g.dart';

@freezed
abstract class GetReservationsResponseEntity
    with _$GetReservationsResponseEntity {
  const factory GetReservationsResponseEntity({
    required List<ReservationModel> reservations,
  }) = _GetReservationsResponseEntity;

  factory GetReservationsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetReservationsResponseEntityFromJson({'reservations': json});
}
