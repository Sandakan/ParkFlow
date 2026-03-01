import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_lot_model.freezed.dart';
part 'parking_lot_model.g.dart';

@freezed
abstract class ParkingLotModel with _$ParkingLotModel {
  const factory ParkingLotModel({
    required String id,
    required String name,
    required bool isOpen,
    required int camerasCount,
    required int totalSlots,
    required double occupancy,
    required int revenueToday,
    required String address,
  }) = _ParkingLotModel;

  factory ParkingLotModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotModelFromJson(json);
}
