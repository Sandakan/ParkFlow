// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_parking_lot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateParkingLotRequest _$CreateParkingLotRequestFromJson(
  Map<String, dynamic> json,
) => _CreateParkingLotRequest(
  name: json['name'] as String,
  address: json['address'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  slotWidthMeters: (json['slot_width_meters'] as num).toDouble(),
  slotLengthMeters: (json['slot_length_meters'] as num).toDouble(),
);

Map<String, dynamic> _$CreateParkingLotRequestToJson(
  _CreateParkingLotRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'slot_width_meters': instance.slotWidthMeters,
  'slot_length_meters': instance.slotLengthMeters,
};
