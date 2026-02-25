// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetUserResponseEntity _$GetUserResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetUserResponseEntity(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$GetUserResponseEntityToJson(
  _GetUserResponseEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'role': instance.role,
};
