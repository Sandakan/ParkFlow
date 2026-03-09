import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_request_entity.freezed.dart';
part 'forgot_password_request_entity.g.dart';

@freezed
abstract class ForgotPasswordRequestEntity with _$ForgotPasswordRequestEntity {
  const factory ForgotPasswordRequestEntity({
    required String email,
  }) = _ForgotPasswordRequestEntity;

  factory ForgotPasswordRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestEntityFromJson(json);
}
