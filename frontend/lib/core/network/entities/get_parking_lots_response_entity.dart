// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

part 'get_parking_lots_response_entity.freezed.dart';
part 'get_parking_lots_response_entity.g.dart';

@freezed
abstract class GetParkingLotsResponseEntity
    with _$GetParkingLotsResponseEntity {
  const GetParkingLotsResponseEntity._();

  const factory GetParkingLotsResponseEntity({
    required List<ParkingLotModel> lots,
  }) = _GetParkingLotsResponseEntity;

  factory GetParkingLotsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetParkingLotsResponseEntityFromJson(json);
}
