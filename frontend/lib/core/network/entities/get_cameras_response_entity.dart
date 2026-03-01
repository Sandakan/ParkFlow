import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/models/parking/camera_model.dart';

part 'get_cameras_response_entity.freezed.dart';
part 'get_cameras_response_entity.g.dart';

@freezed
abstract class GetCamerasResponseEntity with _$GetCamerasResponseEntity {
  const GetCamerasResponseEntity._();

  const factory GetCamerasResponseEntity({required List<CameraModel> cameras}) =
      _GetCamerasResponseEntity;

  factory GetCamerasResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCamerasResponseEntityFromJson(json);
}
