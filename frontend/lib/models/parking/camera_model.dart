import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_model.freezed.dart';
part 'camera_model.g.dart';

@freezed
abstract class CameraModel with _$CameraModel {
  const factory CameraModel({
    required String id,
    required String name,
    required String rtspUrl,
    required String lotId,
    @Default(true) bool isAlive,
    String? lotName,
    String? createdAt,
    String? updatedAt,
  }) = _CameraModel;

  factory CameraModel.fromJson(Map<String, dynamic> json) =>
      _$CameraModelFromJson(json);
}
