// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BaseResponseEntity _$BaseResponseEntityFromJson(Map<String, dynamic> json) =>
    _BaseResponseEntity(
      success: json['success'] as bool,
      message: json['message'] as String,
      code: json['code'] as String,
      statusCode: (json['status_code'] as num).toInt(),
      data: json['data'],
    );

Map<String, dynamic> _$BaseResponseEntityToJson(_BaseResponseEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'status_code': instance.statusCode,
      'data': instance.data,
    };
