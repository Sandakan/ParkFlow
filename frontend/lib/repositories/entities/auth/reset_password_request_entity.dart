import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_request_entity.freezed.dart';
part 'reset_password_request_entity.g.dart';

@freezed
abstract class ResetPasswordRequestEntity with _$ResetPasswordRequestEntity {
  const factory ResetPasswordRequestEntity({
    required String email,
    required String otp,
    required String password,
  }) = _ResetPasswordRequestEntity;

  factory ResetPasswordRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestEntityFromJson(json);
}
