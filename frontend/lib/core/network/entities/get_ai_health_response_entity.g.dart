// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ai_health_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetAiHealthResponseEntity _$GetAiHealthResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetAiHealthResponseEntity(
  avgConfidence: (json['avgConfidence'] as num).toDouble(),
  sampleCount: (json['sampleCount'] as num).toInt(),
  systemCpuPct: (json['systemCpuPct'] as num?)?.toDouble(),
  inferenceLatencyMs: (json['inferenceLatencyMs'] as num?)?.toDouble(),
);

Map<String, dynamic> _$GetAiHealthResponseEntityToJson(
  _GetAiHealthResponseEntity instance,
) => <String, dynamic>{
  'avgConfidence': instance.avgConfidence,
  'sampleCount': instance.sampleCount,
  'systemCpuPct': instance.systemCpuPct,
  'inferenceLatencyMs': instance.inferenceLatencyMs,
};
