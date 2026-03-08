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
    @Default(100.0) double baseRate,
    required String address,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'entrance_logical_locations')
    List<List<int>>? entranceLogicalLocations,
    @JsonKey(name: 'slot_width_meters') double? slotWidthMeters,
    @JsonKey(name: 'slot_length_meters') double? slotLengthMeters,
    double? distanceMeters,
    double? rating,
    int? ratingCount,
  }) = _ParkingLotModel;

  factory ParkingLotModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotModelFromJson(json);
}
