// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_parking_slot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateParkingSlotRequest _$CreateParkingSlotRequestFromJson(
  Map<String, dynamic> json,
) => _CreateParkingSlotRequest(
  lotId: json['lot_id'] as String,
  cameraId: json['camera_id'] as String,
  slotNumber: json['slot_number'] as String,
  slotType: json['slot_type'] as String? ?? 'general',
  logicalRow: (json['logical_row'] as num?)?.toInt() ?? 0,
  logicalCol: (json['logical_col'] as num?)?.toInt() ?? 0,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map((e) => Point2D.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateParkingSlotRequestToJson(
  _CreateParkingSlotRequest instance,
) => <String, dynamic>{
  'lot_id': instance.lotId,
  'camera_id': instance.cameraId,
  'slot_number': instance.slotNumber,
  'slot_type': instance.slotType,
  'logical_row': instance.logicalRow,
  'logical_col': instance.logicalCol,
  'coordinates': instance.coordinates,
};
