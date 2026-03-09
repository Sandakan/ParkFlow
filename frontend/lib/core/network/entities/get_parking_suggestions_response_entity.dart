import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_parking_suggestions_response_entity.freezed.dart';
part 'get_parking_suggestions_response_entity.g.dart';

@freezed
abstract class GetParkingSuggestionsResponseEntity
    with _$GetParkingSuggestionsResponseEntity {
  const factory GetParkingSuggestionsResponseEntity({
    required List<ParkingSuggestionEntity> suggestions,
  }) = _GetParkingSuggestionsResponseEntity;

  factory GetParkingSuggestionsResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$GetParkingSuggestionsResponseEntityFromJson(json);
}

@freezed
abstract class ParkingSuggestionEntity with _$ParkingSuggestionEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ParkingSuggestionEntity({
    @JsonKey(name: 'id') required String slotId,
    @JsonKey(name: 'name') required String slotName,
    required double distanceMeters,
    required int row,
    required int col,
    required String slotType,
  }) = _ParkingSuggestionEntity;

  factory ParkingSuggestionEntity.fromJson(Map<String, dynamic> json) =>
      _$ParkingSuggestionEntityFromJson(json);
}
