// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cameras_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetCamerasResponseEntity _$GetCamerasResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetCamerasResponseEntity(
  cameras: (json['cameras'] as List<dynamic>)
      .map((e) => CameraModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetCamerasResponseEntityToJson(
  _GetCamerasResponseEntity instance,
) => <String, dynamic>{'cameras': instance.cameras};
