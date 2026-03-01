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
  'coordinates': instance.coordinates,
};
