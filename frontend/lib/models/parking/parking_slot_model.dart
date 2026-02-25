import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_slot_model.freezed.dart';
part 'parking_slot_model.g.dart';

@freezed
abstract class ParkingSlotModel with _$ParkingSlotModel {
  const factory ParkingSlotModel({
    required String id,
    required String name,
    required bool isOccupied,
    DateTime? lastUpdated,
  }) = _ParkingSlotModel;

  factory ParkingSlotModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingSlotModelFromJson(json);
}
