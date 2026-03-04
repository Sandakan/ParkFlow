class UpdateInferenceSettingsRequest {
  final double confidenceThreshold;
  final double iouThreshold;
  final int frameSkip;
  final int stabilityBuffer;
  final bool globalInferenceEnabled;

  UpdateInferenceSettingsRequest({
    required this.confidenceThreshold,
    required this.iouThreshold,
    required this.frameSkip,
    required this.stabilityBuffer,
    required this.globalInferenceEnabled,
  });

  Map<String, dynamic> toJson() {
    return {
      'confidence_threshold': confidenceThreshold,
      'iou_threshold': iouThreshold,
      'frame_skip': frameSkip,
      'stability_buffer': stabilityBuffer,
      'global_inference_enabled': globalInferenceEnabled,
    };
  }
}
