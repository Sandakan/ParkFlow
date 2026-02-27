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
  totalSlots: (json['total_slots'] as num?)?.toInt(),
);

Map<String, dynamic> _$UpdateParkingLotRequestToJson(
  _UpdateParkingLotRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'total_slots': instance.totalSlots,
};
