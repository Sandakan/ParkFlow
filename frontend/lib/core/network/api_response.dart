// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake, alwaysCreate: true)
enum ResponseCode {
  success,
  error,
  validationError,
  unauthorized,
  forbidden,
  notFound,
  internalServerError,
  userCreated,
  userFetched,
  userUpdated,
  userDeleted,
  userAlreadyExists,
  userNotFound,
  invalidCredentials,
  loginSuccess,
  tokenRefreshed,
  invalidToken,
  tokenExpired,
  unknown,
}

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();

  @JsonSerializable(
    fieldRename: FieldRename.snake,
    explicitToJson: true,
    genericArgumentFactories: true,
  )
  const factory ApiResponse({
    required bool success,
    required String message,
    @JsonKey(unknownEnumValue: ResponseCode.unknown) required ResponseCode code,
    required int statusCode,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
