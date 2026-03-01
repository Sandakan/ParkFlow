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
      slotType: json['slot_type'] as String?,
      cameraId: json['camera_id'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => Point2D.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$ParkingSlotModelToJson(_ParkingSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isOccupied': instance.isOccupied,
      'slot_type': instance.slotType,
      'camera_id': instance.cameraId,
      'coordinates': instance.coordinates,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
