// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestEntity _$LoginRequestEntityFromJson(Map<String, dynamic> json) =>
    _LoginRequestEntity(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestEntityToJson(_LoginRequestEntity instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
