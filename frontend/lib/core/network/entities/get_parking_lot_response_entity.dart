import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';

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
    @JsonKey(name: 'entrance_logical_locations')
    List<List<int>>? entranceLogicalLocations,
    @JsonKey(name: 'slot_width_meters') double? slotWidthMeters,
    @JsonKey(name: 'slot_length_meters') double? slotLengthMeters,
    @JsonKey(name: 'base_rate') double? baseRate,
  }) = _GetParkingLotResponseEntity;

  factory GetParkingLotResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetParkingLotResponseEntityFromJson(json);

  ParkingLotModel toModel() {
    return ParkingLotModel(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      totalSlots: totalSlots,
      isOpen: true,
      camerasCount: 0,
      occupancy: 0.0,
      revenueToday: 0,
      baseRate: baseRate ?? 100.0,
      entranceLogicalLocations:
          entranceLogicalLocations ??
          [
            [0, 0],
          ],
      slotWidthMeters: slotWidthMeters ?? 5.0,
      slotLengthMeters: slotLengthMeters ?? 5.0,
    );
  }
}
