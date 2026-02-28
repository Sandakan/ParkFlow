import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/services/analytics_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parkflow/core/app_exception.dart';

part 'analytics_notifier.freezed.dart';
part 'analytics_notifier.g.dart';

@freezed
abstract class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    GetAnalyticsOverviewResponseEntity? overview,
    GetOccupancyTrendResponseEntity? trend,
    GetAiHealthResponseEntity? aiHealth,
    @Default('24h') String selectedPeriod,
    @Default(true) bool isLoadingOverview,
    @Default(true) bool isLoadingTrend,
    @Default(true) bool isLoadingAiHealth,
    String? overviewError,
    String? trendError,
    String? aiHealthError,
  }) = _AnalyticsState;
}

@riverpod
class AnalyticsNotifier extends _$AnalyticsNotifier {
  @override
  AnalyticsState build() {
    Future.microtask(() => _fetchAll());
    return const AnalyticsState();
  }

  Future<void> _fetchAll() async {
    _fetchOverview();
    _fetchTrend(state.selectedPeriod);
    _fetchAiHealth();
  }

  Future<void> _fetchOverview() async {
    state = state.copyWith(isLoadingOverview: true, overviewError: null);
    try {
      final overview = await ref.read(analyticsServiceProvider).fetchOverview();
      state = state.copyWith(overview: overview, isLoadingOverview: false);
    } on AppException catch (e) {
      state = state.copyWith(
        overviewError: e.toString(),
        isLoadingOverview: false,
      );
    } catch (e) {
      state = state.copyWith(
        overviewError: 'Failed to load overview: $e',
        isLoadingOverview: false,
      );
    }
  }

  Future<void> _fetchTrend(String period) async {
    state = state.copyWith(isLoadingTrend: true, trendError: null);
    try {
      final trend = await ref
          .read(analyticsServiceProvider)
          .fetchOccupancyTrend(period);
      state = state.copyWith(trend: trend, isLoadingTrend: false);
    } on AppException catch (e) {
      state = state.copyWith(trendError: e.toString(), isLoadingTrend: false);
    } catch (e) {
      state = state.copyWith(
        trendError: 'Failed to load trend: $e',
        isLoadingTrend: false,
      );
    }
  }

  Future<void> _fetchAiHealth() async {
    state = state.copyWith(isLoadingAiHealth: true, aiHealthError: null);
    try {
      final aiHealth = await ref.read(analyticsServiceProvider).fetchAiHealth();
      state = state.copyWith(aiHealth: aiHealth, isLoadingAiHealth: false);
    } on AppException catch (e) {
      state = state.copyWith(
        aiHealthError: e.toString(),
        isLoadingAiHealth: false,
      );
    } catch (e) {
      state = state.copyWith(
        aiHealthError: 'Failed to load AI health: $e',
        isLoadingAiHealth: false,
      );
    }
  }

  Future<void> selectPeriod(String period) async {
    if (state.selectedPeriod == period) return;
    state = state.copyWith(selectedPeriod: period);
    await _fetchTrend(period);
  }

  Future<void> refresh() async {
    await _fetchAll();
  }
}
