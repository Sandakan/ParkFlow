import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkflow/core/network/entities/get_ai_health_response_entity.dart';
import 'package:parkflow/core/network/entities/get_analytics_overview_response_entity.dart';
import 'package:parkflow/core/network/entities/get_occupancy_trend_response_entity.dart';
import 'package:parkflow/services/analytics_service.dart';
import 'package:parkflow/repositories/providers/remote_repository_provider.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import '../helpers/test_helpers.dart';

void main() {
  late MockRemoteRepository mockRemoteRepository;
  late MockAuthNotifier mockAuthNotifier;
  late ProviderContainer container;

  setUp(() {
    mockRemoteRepository = MockRemoteRepository();
    mockAuthNotifier = MockAuthNotifier();

    container = ProviderContainer(
      overrides: [
        remoteRepositoryProvider.overrideWithValue(mockRemoteRepository),
        authProvider.overrideWith(() => mockAuthNotifier),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AnalyticsService', () {
    test('fetchOverview should call remote repository', () async {
      when(() => mockAuthNotifier.getValidAccessToken())
          .thenAnswer((_) async => 'test_token');
      
      const response = GetAnalyticsOverviewResponseEntity(
        totalCapacity: 100,
        totalSlotsCount: 100,
        currentOccupied: 45,
        currentVacant: 55,
        occupancyRate: 0.45,
        activeStreamCount: 5,
        totalCameraCount: 5,
        streamHealthPct: 1.0,
        avgDwellTimeMinutes: 120.5,
        turnoverRateToday: 2.5,
        revenueToday: 1500.0,
        revenueMonth: 45000.0,
      );

      when(() => mockRemoteRepository.getAnalyticsOverview(accessToken: 'test_token'))
          .thenAnswer((_) async => response);

      final service = container.read(analyticsServiceProvider);
      final result = await service.fetchOverview();

      expect(result.totalCapacity, 100);
      expect(result.currentOccupied, 45);
      verify(() => mockRemoteRepository.getAnalyticsOverview(accessToken: 'test_token'))
          .called(1);
    });

    test('fetchOccupancyTrend should call remote repository with period', () async {
      when(() => mockAuthNotifier.getValidAccessToken())
          .thenAnswer((_) async => 'test_token');
      
      const response = GetOccupancyTrendResponseEntity(
        period: '24h',
        points: [
          TrendPointEntity(label: '10:00', occupancy: 10, revenue: 100),
          TrendPointEntity(label: '11:00', occupancy: 20, revenue: 200),
        ],
        comparisonPoints: [
          TrendPointEntity(label: '10:00', occupancy: 5, revenue: 50),
          TrendPointEntity(label: '11:00', occupancy: 15, revenue: 150),
        ],
      );

      when(() => mockRemoteRepository.getOccupancyTrend('24h', accessToken: 'test_token'))
          .thenAnswer((_) async => response);

      final service = container.read(analyticsServiceProvider);
      final result = await service.fetchOccupancyTrend('24h');

      expect(result.points.first.label, '10:00');
      verify(() => mockRemoteRepository.getOccupancyTrend('24h', accessToken: 'test_token'))
          .called(1);
    });

    test('fetchAiHealth should call remote repository', () async {
      when(() => mockAuthNotifier.getValidAccessToken())
          .thenAnswer((_) async => 'test_token');
      
      const response = GetAiHealthResponseEntity(
        avgConfidence: 0.95,
        sampleCount: 1000,
      );

      when(() => mockRemoteRepository.getAiHealth(accessToken: 'test_token'))
          .thenAnswer((_) async => response);

      final service = container.read(analyticsServiceProvider);
      final result = await service.fetchAiHealth();

      expect(result.avgConfidence, 0.95);
      expect(result.sampleCount, 1000);
      verify(() => mockRemoteRepository.getAiHealth(accessToken: 'test_token'))
          .called(1);
    });
  });
}
