// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseEntity _$LoginResponseEntityFromJson(Map<String, dynamic> json) =>
    _LoginResponseEntity(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      accessTokenExpiresAt: json['access_token_expires_at'] as String,
      refreshTokenExpiresAt: json['refresh_token_expires_at'] as String,
    );

Map<String, dynamic> _$LoginResponseEntityToJson(
  _LoginResponseEntity instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'token_type': instance.tokenType,
  'access_token_expires_at': instance.accessTokenExpiresAt,
  'refresh_token_expires_at': instance.refreshTokenExpiresAt,
};
