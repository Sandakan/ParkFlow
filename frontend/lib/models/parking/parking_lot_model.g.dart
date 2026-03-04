// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParkingLotModel _$ParkingLotModelFromJson(Map<String, dynamic> json) =>
    _ParkingLotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isOpen: json['isOpen'] as bool,
      camerasCount: (json['camerasCount'] as num).toInt(),
      totalSlots: (json['totalSlots'] as num).toInt(),
      occupancy: (json['occupancy'] as num).toDouble(),
      revenueToday: (json['revenueToday'] as num).toInt(),
      address: json['address'] as String,
      entranceLogicalLocations:
          (json['entrance_logical_locations'] as List<dynamic>?)
              ?.map(
                (e) => (e as List<dynamic>)
                    .map((e) => (e as num).toInt())
                    .toList(),
              )
              .toList(),
      slotWidthMeters: (json['slot_width_meters'] as num?)?.toDouble(),
      slotLengthMeters: (json['slot_length_meters'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ParkingLotModelToJson(_ParkingLotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isOpen': instance.isOpen,
      'camerasCount': instance.camerasCount,
      'totalSlots': instance.totalSlots,
      'occupancy': instance.occupancy,
      'revenueToday': instance.revenueToday,
      'address': instance.address,
      'entrance_logical_locations': instance.entranceLogicalLocations,
      'slot_width_meters': instance.slotWidthMeters,
      'slot_length_meters': instance.slotLengthMeters,
    };
