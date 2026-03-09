import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';
part 'notification_entity.g.dart';

enum NotificationType {
  @JsonValue('info')
  info,
  @JsonValue('success')
  success,
  @JsonValue('warning')
  warning,
  @JsonValue('error')
  error,
}

@freezed
abstract class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String message,
    @Default(NotificationType.info) NotificationType type,
    @Default({}) Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'read_at') DateTime? readAt,
    @JsonKey(name: 'user_id') String? userId,
  }) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);
}
