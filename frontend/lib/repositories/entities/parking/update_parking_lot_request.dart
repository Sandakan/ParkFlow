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
    @JsonKey(name: 'total_slots') int? totalSlots,
  }) = _UpdateParkingLotRequest;

  factory UpdateParkingLotRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateParkingLotRequestFromJson(json);
}
