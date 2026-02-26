// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_entity.freezed.dart';
part 'register_request_entity.g.dart';

@freezed
abstract class RegisterRequestEntity with _$RegisterRequestEntity {
  const RegisterRequestEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RegisterRequestEntity({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "password") required String password,
  }) = _RegisterRequestEntity;

  factory RegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestEntityFromJson(json);
}
