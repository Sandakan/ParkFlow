// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_parking_lot_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetParkingLotResponseEntity _$GetParkingLotResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetParkingLotResponseEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  totalSlots: (json['totalSlots'] as num).toInt(),
  entranceLogicalLocations:
      (json['entrance_logical_locations'] as List<dynamic>?)
          ?.map(
            (e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
          )
          .toList(),
  slotWidthMeters: (json['slot_width_meters'] as num?)?.toDouble(),
  slotLengthMeters: (json['slot_length_meters'] as num?)?.toDouble(),
);

Map<String, dynamic> _$GetParkingLotResponseEntityToJson(
  _GetParkingLotResponseEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'totalSlots': instance.totalSlots,
  'entrance_logical_locations': instance.entranceLogicalLocations,
  'slot_width_meters': instance.slotWidthMeters,
  'slot_length_meters': instance.slotLengthMeters,
};
