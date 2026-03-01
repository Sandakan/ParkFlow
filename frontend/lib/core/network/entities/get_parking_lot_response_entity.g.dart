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
};
