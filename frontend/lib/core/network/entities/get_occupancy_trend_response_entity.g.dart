// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_occupancy_trend_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrendPointEntity _$TrendPointEntityFromJson(Map<String, dynamic> json) =>
    _TrendPointEntity(
      label: json['label'] as String,
      occupancy: (json['occupancy'] as num).toDouble(),
      revenue: (json['revenue'] as num).toDouble(),
    );

Map<String, dynamic> _$TrendPointEntityToJson(_TrendPointEntity instance) =>
    <String, dynamic>{
      'label': instance.label,
      'occupancy': instance.occupancy,
      'revenue': instance.revenue,
    };

_GetOccupancyTrendResponseEntity _$GetOccupancyTrendResponseEntityFromJson(
  Map<String, dynamic> json,
) => _GetOccupancyTrendResponseEntity(
  period: json['period'] as String,
  points: (json['points'] as List<dynamic>)
      .map((e) => TrendPointEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  comparisonPoints: (json['comparisonPoints'] as List<dynamic>)
      .map((e) => TrendPointEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetOccupancyTrendResponseEntityToJson(
  _GetOccupancyTrendResponseEntity instance,
) => <String, dynamic>{
  'period': instance.period,
  'points': instance.points,
  'comparisonPoints': instance.comparisonPoints,
};
