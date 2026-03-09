import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_occupancy_trend_response_entity.freezed.dart';
part 'get_occupancy_trend_response_entity.g.dart';

@freezed
abstract class TrendPointEntity with _$TrendPointEntity {
  const factory TrendPointEntity({
    required String label,
    required double occupancy,
    required double revenue,
  }) = _TrendPointEntity;

  factory TrendPointEntity.fromJson(Map<String, dynamic> json) =>
      _$TrendPointEntityFromJson(json);
}

@freezed
abstract class GetOccupancyTrendResponseEntity
    with _$GetOccupancyTrendResponseEntity {
  const factory GetOccupancyTrendResponseEntity({
    required String period,
    required List<TrendPointEntity> points,
    required List<TrendPointEntity> comparisonPoints,
  }) = _GetOccupancyTrendResponseEntity;

  factory GetOccupancyTrendResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetOccupancyTrendResponseEntityFromJson(json);
}
