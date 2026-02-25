// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_entity.freezed.dart';
part 'login_response_entity.g.dart';

@freezed
abstract class LoginResponseEntity with _$LoginResponseEntity {
  const LoginResponseEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoginResponseEntity({
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "refresh_token") required String refreshToken,
    @JsonKey(name: "token_type") required String tokenType,
  }) = _LoginResponseEntity;

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseEntityFromJson(json);
}
