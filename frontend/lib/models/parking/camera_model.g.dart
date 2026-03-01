// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CameraModel _$CameraModelFromJson(Map<String, dynamic> json) => _CameraModel(
  id: json['id'] as String,
  name: json['name'] as String,
  rtspUrl: json['rtspUrl'] as String,
  lotId: json['lotId'] as String,
  lotName: json['lotName'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CameraModelToJson(_CameraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rtspUrl': instance.rtspUrl,
      'lotId': instance.lotId,
      'lotName': instance.lotName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
