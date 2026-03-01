// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_response_entity.freezed.dart';
part 'get_user_response_entity.g.dart';

@freezed
abstract class GetUserResponseEntity with _$GetUserResponseEntity {
  const GetUserResponseEntity._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetUserResponseEntity({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "role") required String role,
  }) = _GetUserResponseEntity;

  factory GetUserResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseEntityFromJson(json);
}
