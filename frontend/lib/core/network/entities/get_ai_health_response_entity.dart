import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ai_health_response_entity.freezed.dart';
part 'get_ai_health_response_entity.g.dart';

@freezed
abstract class GetAiHealthResponseEntity with _$GetAiHealthResponseEntity {
  const factory GetAiHealthResponseEntity({
    required double avgConfidence,
    required int sampleCount,
    double? systemCpuPct,
    double? inferenceLatencyMs,
  }) = _GetAiHealthResponseEntity;

  factory GetAiHealthResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAiHealthResponseEntityFromJson(json);
}
