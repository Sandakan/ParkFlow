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
      lotId: json['lot_id'] as String?,
      slotType: json['slot_type'] as String?,
      cameraId: json['camera_id'] as String?,
      logicalRow: (json['logical_row'] as num?)?.toInt() ?? 0,
      logicalCol: (json['logical_col'] as num?)?.toInt() ?? 0,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => Point2D.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingSlotModelToJson(_ParkingSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isOccupied': instance.isOccupied,
      'lot_id': instance.lotId,
      'slot_type': instance.slotType,
      'camera_id': instance.cameraId,
      'logical_row': instance.logicalRow,
      'logical_col': instance.logicalCol,
      'coordinates': instance.coordinates,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
    };
