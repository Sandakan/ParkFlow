import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_analytics_overview_response_entity.freezed.dart';
part 'get_analytics_overview_response_entity.g.dart';

@freezed
abstract class GetAnalyticsOverviewResponseEntity
    with _$GetAnalyticsOverviewResponseEntity {
  const factory GetAnalyticsOverviewResponseEntity({
    required int totalCapacity,
    required int totalSlotsCount,
    required int currentOccupied,
    required int currentVacant,
    required double occupancyRate,
    required int activeStreamCount,
    required int totalCameraCount,
    required double streamHealthPct,
    required double avgDwellTimeMinutes,
    required double turnoverRateToday,
    required double revenueToday,
    required double revenueMonth,
  }) = _GetAnalyticsOverviewResponseEntity;

  factory GetAnalyticsOverviewResponseEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$GetAnalyticsOverviewResponseEntityFromJson(json);
}
