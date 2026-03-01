// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_camera_request.freezed.dart';
part 'create_camera_request.g.dart';

@freezed
abstract class CreateCameraRequest with _$CreateCameraRequest {
  const factory CreateCameraRequest({
    @JsonKey(name: 'lot_id') required String lotId,
    required String name,
    @JsonKey(name: 'rtsp_url') required String rtspUrl,
  }) = _CreateCameraRequest;

  factory CreateCameraRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCameraRequestFromJson(json);
}
