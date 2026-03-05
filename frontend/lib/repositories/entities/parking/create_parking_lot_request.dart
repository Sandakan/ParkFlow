// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_parking_lot_request.freezed.dart';
part 'create_parking_lot_request.g.dart';

@freezed
abstract class CreateParkingLotRequest with _$CreateParkingLotRequest {
  const CreateParkingLotRequest._();

  const factory CreateParkingLotRequest({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'total_slots') required int totalSlots,
    @JsonKey(name: 'slot_width_meters') required double slotWidthMeters,
    @JsonKey(name: 'slot_length_meters') required double slotLengthMeters,
  }) = _CreateParkingLotRequest;

  factory CreateParkingLotRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateParkingLotRequestFromJson(json);
}
