class GetInferenceSettingsResponseEntity {
  final double confidenceThreshold;
  final double iouThreshold;
  final int frameSkip;
  final int stabilityBuffer;
  final bool globalInferenceEnabled;

  GetInferenceSettingsResponseEntity({
    required this.confidenceThreshold,
    required this.iouThreshold,
    required this.frameSkip,
    required this.stabilityBuffer,
    required this.globalInferenceEnabled,
  });

  factory GetInferenceSettingsResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetInferenceSettingsResponseEntity(
      confidenceThreshold: (json['confidence_threshold'] as num).toDouble(),
      iouThreshold: (json['iou_threshold'] as num).toDouble(),
      frameSkip: json['frame_skip'] as int,
      stabilityBuffer: json['stability_buffer'] as int,
      globalInferenceEnabled:
          json['global_inference_enabled'] as bool? ?? false,
    );
  }
}
