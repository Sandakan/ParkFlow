import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response_entity.freezed.dart';
part 'base_response_entity.g.dart';

@freezed
abstract class BaseResponseEntity with _$BaseResponseEntity {
  const factory BaseResponseEntity({
    required bool success,
    required String message,
    required String code,
    @JsonKey(name: 'status_code') required int statusCode,
    required dynamic data,
  }) = _BaseResponseEntity;

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseEntityFromJson(json);
}
