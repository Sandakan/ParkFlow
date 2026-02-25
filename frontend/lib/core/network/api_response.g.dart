// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  success: json['success'] as bool,
  message: json['message'] as String,
  code: $enumDecode(
    _$ResponseCodeEnumMap,
    json['code'],
    unknownValue: ResponseCode.unknown,
  ),
  statusCode: (json['status_code'] as num).toInt(),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'code': _$ResponseCodeEnumMap[instance.code]!,
  'status_code': instance.statusCode,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

const _$ResponseCodeEnumMap = {
  ResponseCode.success: 'SUCCESS',
  ResponseCode.error: 'ERROR',
  ResponseCode.validationError: 'VALIDATION_ERROR',
  ResponseCode.unauthorized: 'UNAUTHORIZED',
  ResponseCode.forbidden: 'FORBIDDEN',
  ResponseCode.notFound: 'NOT_FOUND',
  ResponseCode.internalServerError: 'INTERNAL_SERVER_ERROR',
  ResponseCode.userCreated: 'USER_CREATED',
  ResponseCode.userFetched: 'USER_FETCHED',
  ResponseCode.userUpdated: 'USER_UPDATED',
  ResponseCode.userDeleted: 'USER_DELETED',
  ResponseCode.userAlreadyExists: 'USER_ALREADY_EXISTS',
  ResponseCode.userNotFound: 'USER_NOT_FOUND',
  ResponseCode.invalidCredentials: 'INVALID_CREDENTIALS',
  ResponseCode.loginSuccess: 'LOGIN_SUCCESS',
  ResponseCode.tokenRefreshed: 'TOKEN_REFRESHED',
  ResponseCode.invalidToken: 'INVALID_TOKEN',
  ResponseCode.tokenExpired: 'TOKEN_EXPIRED',
  ResponseCode.unknown: 'UNKNOWN',
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
