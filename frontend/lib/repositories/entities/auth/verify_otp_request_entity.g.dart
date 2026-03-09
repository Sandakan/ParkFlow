// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyOtpRequestEntity _$VerifyOtpRequestEntityFromJson(
  Map<String, dynamic> json,
) => _VerifyOtpRequestEntity(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$VerifyOtpRequestEntityToJson(
  _VerifyOtpRequestEntity instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};
