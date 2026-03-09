import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/repositories/entities/parking/point2d.dart';

part 'create_parking_slot_request.freezed.dart';
part 'create_parking_slot_request.g.dart';

@freezed
abstract class CreateParkingSlotRequest with _$CreateParkingSlotRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateParkingSlotRequest({
    required String lotId,
    required String cameraId,
    required String slotNumber,
    @Default('general') String slotType,
    @JsonKey(name: 'logical_row') @Default(0) int logicalRow,
    @JsonKey(name: 'logical_col') @Default(0) int logicalCol,
    required List<Point2D> coordinates,
  }) = _CreateParkingSlotRequest;

  factory CreateParkingSlotRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateParkingSlotRequestFromJson(json);
}
