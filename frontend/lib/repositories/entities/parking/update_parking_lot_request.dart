// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_parking_lot_request.freezed.dart';
part 'update_parking_lot_request.g.dart';

@freezed
abstract class UpdateParkingLotRequest with _$UpdateParkingLotRequest {
  const UpdateParkingLotRequest._();

  const factory UpdateParkingLotRequest({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'entrance_logical_locations')
    List<List<int>>? entranceLogicalLocations,
    @JsonKey(name: 'slot_width_meters') double? slotWidthMeters,
    @JsonKey(name: 'slot_length_meters') double? slotLengthMeters,
    @JsonKey(name: 'base_rate') double? baseRate,
  }) = _UpdateParkingLotRequest;

  factory UpdateParkingLotRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateParkingLotRequestFromJson(json);
}
