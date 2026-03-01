// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_parking_lot_response_entity.freezed.dart';
part 'get_parking_lot_response_entity.g.dart';

@freezed
abstract class GetParkingLotResponseEntity with _$GetParkingLotResponseEntity {
  const GetParkingLotResponseEntity._();

  const factory GetParkingLotResponseEntity({
    required String id,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    required int totalSlots,
  }) = _GetParkingLotResponseEntity;

  factory GetParkingLotResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetParkingLotResponseEntityFromJson(json);
}
