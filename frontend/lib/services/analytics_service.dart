import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_service.g.dart';

class AnalyticsService {
  final RemoteRepositoryInterface _remote;

  AnalyticsService(this._remote);

  Future<GetAnalyticsOverviewResponseEntity> fetchOverview() async {
    try {
      return await _remote.getAnalyticsOverview();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetOccupancyTrendResponseEntity> fetchOccupancyTrend(
    String period,
  ) async {
    try {
      return await _remote.getOccupancyTrend(period);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetAiHealthResponseEntity> fetchAiHealth() async {
    try {
      return await _remote.getAiHealth();
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}

@riverpod
AnalyticsService analyticsService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  return AnalyticsService(remote);
}
