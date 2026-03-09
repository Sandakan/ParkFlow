// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_analytics_overview_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetAnalyticsOverviewResponseEntity
_$GetAnalyticsOverviewResponseEntityFromJson(Map<String, dynamic> json) =>
    _GetAnalyticsOverviewResponseEntity(
      totalCapacity: (json['totalCapacity'] as num).toInt(),
      totalSlotsCount: (json['totalSlotsCount'] as num).toInt(),
      currentOccupied: (json['currentOccupied'] as num).toInt(),
      currentVacant: (json['currentVacant'] as num).toInt(),
      occupancyRate: (json['occupancyRate'] as num).toDouble(),
      activeStreamCount: (json['activeStreamCount'] as num).toInt(),
      totalCameraCount: (json['totalCameraCount'] as num).toInt(),
      streamHealthPct: (json['streamHealthPct'] as num).toDouble(),
      avgDwellTimeMinutes: (json['avgDwellTimeMinutes'] as num).toDouble(),
      turnoverRateToday: (json['turnoverRateToday'] as num).toDouble(),
      revenueToday: (json['revenueToday'] as num).toDouble(),
      revenueMonth: (json['revenueMonth'] as num).toDouble(),
    );

Map<String, dynamic> _$GetAnalyticsOverviewResponseEntityToJson(
  _GetAnalyticsOverviewResponseEntity instance,
) => <String, dynamic>{
  'totalCapacity': instance.totalCapacity,
  'totalSlotsCount': instance.totalSlotsCount,
  'currentOccupied': instance.currentOccupied,
  'currentVacant': instance.currentVacant,
  'occupancyRate': instance.occupancyRate,
  'activeStreamCount': instance.activeStreamCount,
  'totalCameraCount': instance.totalCameraCount,
  'streamHealthPct': instance.streamHealthPct,
  'avgDwellTimeMinutes': instance.avgDwellTimeMinutes,
  'turnoverRateToday': instance.turnoverRateToday,
  'revenueToday': instance.revenueToday,
  'revenueMonth': instance.revenueMonth,
};
