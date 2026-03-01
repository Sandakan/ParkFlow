import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_camera_request.freezed.dart';
part 'update_camera_request.g.dart';

@freezed
abstract class UpdateCameraRequest with _$UpdateCameraRequest {
  const factory UpdateCameraRequest({String? name, String? rtspUrl}) =
      _UpdateCameraRequest;

  factory UpdateCameraRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCameraRequestFromJson(json);
}
