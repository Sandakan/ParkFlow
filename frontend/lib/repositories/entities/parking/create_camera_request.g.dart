// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_camera_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateCameraRequest _$CreateCameraRequestFromJson(Map<String, dynamic> json) =>
    _CreateCameraRequest(
      lotId: json['lot_id'] as String,
      name: json['name'] as String,
      rtspUrl: json['rtsp_url'] as String,
    );

Map<String, dynamic> _$CreateCameraRequestToJson(
  _CreateCameraRequest instance,
) => <String, dynamic>{
  'lot_id': instance.lotId,
  'name': instance.name,
  'rtsp_url': instance.rtspUrl,
};
