// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_detection_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetectedBox _$DetectedBoxFromJson(Map<String, dynamic> json) => _DetectedBox(
  label: json['label'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  x1: (json['x1'] as num).toDouble(),
  y1: (json['y1'] as num).toDouble(),
  x2: (json['x2'] as num).toDouble(),
  y2: (json['y2'] as num).toDouble(),
);

Map<String, dynamic> _$DetectedBoxToJson(_DetectedBox instance) =>
    <String, dynamic>{
      'label': instance.label,
      'confidence': instance.confidence,
      'x1': instance.x1,
      'y1': instance.y1,
      'x2': instance.x2,
      'y2': instance.y2,
    };

_SlotHit _$SlotHitFromJson(Map<String, dynamic> json) => _SlotHit(
  slotId: json['slot_id'] as String,
  mappingId: json['mapping_id'] as String,
  isOccupied: json['is_occupied'] as bool,
);

Map<String, dynamic> _$SlotHitToJson(_SlotHit instance) => <String, dynamic>{
  'slot_id': instance.slotId,
  'mapping_id': instance.mappingId,
  'is_occupied': instance.isOccupied,
};

_AiDetectionEvent _$AiDetectionEventFromJson(Map<String, dynamic> json) =>
    _AiDetectionEvent(
      cameraId: json['camera_id'] as String,
      timestamp: json['timestamp'] as String,
      detections:
          (json['detections'] as List<dynamic>?)
              ?.map((e) => DetectedBox.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      slotHits:
          (json['slot_hits'] as List<dynamic>?)
              ?.map((e) => SlotHit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AiDetectionEventToJson(_AiDetectionEvent instance) =>
    <String, dynamic>{
      'camera_id': instance.cameraId,
      'timestamp': instance.timestamp,
      'detections': instance.detections,
      'slot_hits': instance.slotHits,
    };
