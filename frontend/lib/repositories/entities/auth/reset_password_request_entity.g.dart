// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResetPasswordRequestEntity _$ResetPasswordRequestEntityFromJson(
  Map<String, dynamic> json,
) => _ResetPasswordRequestEntity(
  email: json['email'] as String,
  otp: json['otp'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestEntityToJson(
  _ResetPasswordRequestEntity instance,
) => <String, dynamic>{
  'email': instance.email,
  'otp': instance.otp,
  'password': instance.password,
};
