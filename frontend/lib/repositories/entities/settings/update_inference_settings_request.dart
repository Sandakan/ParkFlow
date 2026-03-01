class UpdateInferenceSettingsRequest {
  final double confidenceThreshold;
  final double iouThreshold;
  final int frameSkip;
  final int stabilityBuffer;

  UpdateInferenceSettingsRequest({
    required this.confidenceThreshold,
    required this.iouThreshold,
    required this.frameSkip,
    required this.stabilityBuffer,
  });

  Map<String, dynamic> toJson() {
    return {
      'confidence_threshold': confidenceThreshold,
      'iou_threshold': iouThreshold,
      'frame_skip': frameSkip,
      'stability_buffer': stabilityBuffer,
    };
  }
}
