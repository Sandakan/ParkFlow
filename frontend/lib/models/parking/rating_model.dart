import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_model.freezed.dart';
part 'rating_model.g.dart';

@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'reservation_id') required String reservationId,
    @JsonKey(name: 'slot_id') required String slotId,
    @JsonKey(name: 'lot_id') required String lotId,
    required double rating,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _RatingModel;

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}

@freezed
abstract class RatingRequest with _$RatingRequest {
  const factory RatingRequest({required double rating, String? comment}) =
      _RatingRequest;

  factory RatingRequest.fromJson(Map<String, dynamic> json) =>
      _$RatingRequestFromJson(json);
}
