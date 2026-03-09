// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_entity.freezed.dart';
part 'login_request_entity.g.dart';

@freezed
abstract class LoginRequestEntity with _$LoginRequestEntity {
  const LoginRequestEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoginRequestEntity({
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "password") required String password,
  }) = _LoginRequestEntity;

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestEntityFromJson(json);
}
