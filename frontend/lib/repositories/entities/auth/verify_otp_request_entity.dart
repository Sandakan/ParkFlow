import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_request_entity.freezed.dart';
part 'verify_otp_request_entity.g.dart';

@freezed
abstract class VerifyOtpRequestEntity with _$VerifyOtpRequestEntity {
  const factory VerifyOtpRequestEntity({
    required String email,
    required String otp,
  }) = _VerifyOtpRequestEntity;

  factory VerifyOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestEntityFromJson(json);
}
