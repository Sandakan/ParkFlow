// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_parking_suggestions_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetParkingSuggestionsResponseEntity
_$GetParkingSuggestionsResponseEntityFromJson(Map<String, dynamic> json) =>
    _GetParkingSuggestionsResponseEntity(
      suggestions: (json['suggestions'] as List<dynamic>)
          .map(
            (e) => ParkingSuggestionEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$GetParkingSuggestionsResponseEntityToJson(
  _GetParkingSuggestionsResponseEntity instance,
) => <String, dynamic>{'suggestions': instance.suggestions};

_ParkingSuggestionEntity _$ParkingSuggestionEntityFromJson(
  Map<String, dynamic> json,
) => _ParkingSuggestionEntity(
  slotId: json['id'] as String,
  slotName: json['name'] as String,
  distanceMeters: (json['distance_meters'] as num).toDouble(),
  row: (json['row'] as num).toInt(),
  col: (json['col'] as num).toInt(),
  slotType: json['slot_type'] as String,
);

Map<String, dynamic> _$ParkingSuggestionEntityToJson(
  _ParkingSuggestionEntity instance,
) => <String, dynamic>{
  'id': instance.slotId,
  'name': instance.slotName,
  'distance_meters': instance.distanceMeters,
  'row': instance.row,
  'col': instance.col,
  'slot_type': instance.slotType,
};
