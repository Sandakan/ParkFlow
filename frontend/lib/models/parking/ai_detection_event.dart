import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_detection_event.freezed.dart';
part 'ai_detection_event.g.dart';

@freezed
abstract class DetectedBox with _$DetectedBox {
  const factory DetectedBox({
    required String label,
    required double confidence,
    required double x1,
    required double y1,
    required double x2,
    required double y2,
  }) = _DetectedBox;

  factory DetectedBox.fromJson(Map<String, dynamic> json) =>
      _$DetectedBoxFromJson(json);
}

@freezed
abstract class SlotHit with _$SlotHit {
  const factory SlotHit({
    @JsonKey(name: 'slot_id') required String slotId,
    @JsonKey(name: 'mapping_id') required String mappingId,
    @JsonKey(name: 'is_occupied') required bool isOccupied,
  }) = _SlotHit;

  factory SlotHit.fromJson(Map<String, dynamic> json) =>
      _$SlotHitFromJson(json);
}

@freezed
abstract class AiDetectionEvent with _$AiDetectionEvent {
  const factory AiDetectionEvent({
    @JsonKey(name: 'camera_id') required String cameraId,
    required String timestamp,
    @Default([]) List<DetectedBox> detections,
    @JsonKey(name: 'slot_hits') @Default([]) List<SlotHit> slotHits,
  }) = _AiDetectionEvent;

  factory AiDetectionEvent.fromJson(Map<String, dynamic> json) =>
      _$AiDetectionEventFromJson(json);
}
