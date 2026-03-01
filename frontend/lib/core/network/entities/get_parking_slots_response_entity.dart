// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';

part 'get_parking_slots_response_entity.freezed.dart';
part 'get_parking_slots_response_entity.g.dart';

@freezed
abstract class GetParkingSlotsResponseEntity
    with _$GetParkingSlotsResponseEntity {
  const GetParkingSlotsResponseEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetParkingSlotsResponseEntity({
    @JsonKey(name: "slots") required List<ParkingSlotModel> slots,
  }) = _GetParkingSlotsResponseEntity;

  factory GetParkingSlotsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetParkingSlotsResponseEntityFromJson(json);
}
