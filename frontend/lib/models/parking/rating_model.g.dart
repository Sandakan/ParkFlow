// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => _RatingModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  reservationId: json['reservation_id'] as String,
  slotId: json['slot_id'] as String,
  lotId: json['lot_id'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$RatingModelToJson(_RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'reservation_id': instance.reservationId,
      'slot_id': instance.slotId,
      'lot_id': instance.lotId,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
    };

_RatingRequest _$RatingRequestFromJson(Map<String, dynamic> json) =>
    _RatingRequest(
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$RatingRequestToJson(_RatingRequest instance) =>
    <String, dynamic>{'rating': instance.rating, 'comment': instance.comment};
