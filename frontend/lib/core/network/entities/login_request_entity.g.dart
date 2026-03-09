// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestEntity _$LoginRequestEntityFromJson(Map<String, dynamic> json) =>
    _LoginRequestEntity(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestEntityToJson(_LoginRequestEntity instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
