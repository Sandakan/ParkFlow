// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_parking_lot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateParkingLotRequest _$UpdateParkingLotRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateParkingLotRequest(
  name: json['name'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  entranceLogicalLocations:
      (json['entrance_logical_locations'] as List<dynamic>?)
          ?.map(
            (e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
          )
          .toList(),
  slotWidthMeters: (json['slot_width_meters'] as num?)?.toDouble(),
  slotLengthMeters: (json['slot_length_meters'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UpdateParkingLotRequestToJson(
  _UpdateParkingLotRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'entrance_logical_locations': instance.entranceLogicalLocations,
  'slot_width_meters': instance.slotWidthMeters,
  'slot_length_meters': instance.slotLengthMeters,
};
