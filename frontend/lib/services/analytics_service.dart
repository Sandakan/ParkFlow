import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/repositories/interfaces/remote_repository_interface.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/utils/handlers/error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/repositories/providers/env_repository_provider.dart';

part 'analytics_service.g.dart';

class AnalyticsService {
  final RemoteRepositoryInterface _remote;
  final Ref _ref;

  AnalyticsService(this._remote, this._ref);

  Future<String?> _getToken() =>
      _ref.read(authProvider.notifier).getValidAccessToken();

  Future<GetAnalyticsOverviewResponseEntity> fetchOverview() async {
    try {
      return await _remote.getAnalyticsOverview(accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetOccupancyTrendResponseEntity> fetchOccupancyTrend(
    String period,
  ) async {
    try {
      return await _remote.getOccupancyTrend(
        period,
        accessToken: await _getToken(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<GetAiHealthResponseEntity> fetchAiHealth() async {
    try {
      return await _remote.getAiHealth(accessToken: await _getToken());
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<String> getReportUrl(String period) async {
    final baseUrl = _ref.read(envRepositoryProvider).getBaseUrl();
    final token = await _getToken();
    final url =
        '${baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'}analytics/report?period=$period&token=$token';
    return url;
  }
}

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  final remote = ref.watch(remoteRepositoryProvider);
  return AnalyticsService(remote, ref);
}
