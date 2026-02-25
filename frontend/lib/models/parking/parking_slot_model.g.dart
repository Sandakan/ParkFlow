// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParkingSlotModel _$ParkingSlotModelFromJson(Map<String, dynamic> json) =>
    _ParkingSlotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isOccupied: json['isOccupied'] as bool,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$ParkingSlotModelToJson(_ParkingSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isOccupied': instance.isOccupied,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
