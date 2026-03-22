import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/analytics/analytics_notifier.dart';
import 'package:parkflow/services/analytics_service.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminAnalyticsScreen extends ConsumerWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analyticsProvider);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: RefreshIndicator(
              onRefresh: () => ref.read(analyticsProvider.notifier).refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PageHeader(
                          onRefresh: () =>
                              ref.read(analyticsProvider.notifier).refresh(),
                        ),
                        const SizedBox(height: 24),

                        _SectionLabel(l10n.analyticsOverview),
                        const SizedBox(height: 12),
                        _VitalsGrid(state: state, isWide: isWide),
                        const SizedBox(height: 24),

                        if (isWide) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _SectionLabel(l10n.analyticsOccupancyTrend),
                                    const SizedBox(height: 12),
                                    _OccupancyTrendCard(state: state),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _SectionLabel(l10n.analyticsRevenueTrend),
                                    const SizedBox(height: 12),
                                    _RevenueTrendCard(state: state),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _SectionLabel(
                                      l10n.analyticsOperationalImpact,
                                    ),
                                    const SizedBox(height: 12),
                                    _OperationalImpactRow(state: state),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _SectionLabel(l10n.analyticsAiHealth),
                                    const SizedBox(height: 12),
                                    _AiHealthCard(state: state),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          _SectionLabel(l10n.analyticsOccupancyTrend),
                          const SizedBox(height: 12),
                          _OccupancyTrendCard(state: state),
                          const SizedBox(height: 24),

                          _SectionLabel(l10n.analyticsRevenueTrend),
                          const SizedBox(height: 12),
                          _RevenueTrendCard(state: state),
                          const SizedBox(height: 24),

                          _SectionLabel(l10n.analyticsOperationalImpact),
                          const SizedBox(height: 12),
                          _OperationalImpactRow(state: state),
                          const SizedBox(height: 24),

                          _SectionLabel(context.l10n.analyticsAiHealth),
                          const SizedBox(height: 12),
                          _AiHealthCard(state: state),
                        ],
                        const SizedBox(height: 32),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends ConsumerWidget {
  final VoidCallback onRefresh;

  const _PageHeader({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(analyticsProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.analyticsTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.analyticsOccupancyTrendSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            try {
              final url = await ref
                  .read(analyticsServiceProvider)
                  .getReportUrl(state.selectedPeriod);

              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to download report: $e')),
                );
              }
            }
          },
          icon: const Icon(Icons.download_rounded),
          tooltip: context.l10n.analyticsDownloadReport,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh_rounded),
          tooltip: context.l10n.analyticsRefresh,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
        color: AppColors.textSecondary.withValues(alpha: 0.8),
      ),
    );
  }
}

class _VitalsGrid extends StatelessWidget {
  final AnalyticsState state;
  final bool isWide;

  const _VitalsGrid({required this.state, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    final ov = state.overview;
    final l10n = context.l10n;

    final occupied = ov?.currentOccupied;
    final total = ov?.totalSlotsCount ?? ov?.totalCapacity ?? 0;
    final occupancyRate = (ov != null && total > 0) ? (occupied! / total) : 0.0;
    final occupancyPct = occupancyRate * 100;

    final streamPct = ov != null ? (ov.streamHealthPct * 100).round() : null;

    return GridView.count(
      crossAxisCount: isWide ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isWide ? 1.8 : 1.4,
      children: [
        _KpiCard(
          icon: Icons.local_parking_rounded,
          label: l10n.analyticsTotalCapacity,
          value: ov != null ? '${ov.totalCapacity}' : null,
          subtitle: '${ov?.totalSlotsCount ?? 0} ${l10n.analyticsSlots}',
          isLoading: state.isLoadingOverview,
        ),
        _KpiCard(
          icon: Icons.directions_car_filled_rounded,
          label: l10n.analyticsOccupancy,
          value: ov != null ? '${occupancyPct.toStringAsFixed(1)}%' : null,
          subtitle: '${ov?.currentOccupied ?? 0} ${l10n.analyticsOccupied}',
          isLoading: state.isLoadingOverview,
          valueColor: _getOccupancyColor(occupancyRate),
        ),
        _KpiCard(
          icon: Icons.videocam_rounded,
          label: l10n.analyticsStreamHealth,
          value: streamPct != null ? '$streamPct%' : null,
          subtitle:
              '${ov?.activeStreamCount ?? 0}/${ov?.totalCameraCount ?? 0} ${l10n.analyticsLiveStatus}',
          isLoading: state.isLoadingOverview,
          valueColor: _getStreamHealthColor(ov?.streamHealthPct ?? 0),
        ),
        _KpiCard(
          icon: Icons.access_time_filled_rounded,
          label: l10n.analyticsAvgDwell,
          value: ov != null
              ? '${ov.avgDwellTimeMinutes.toStringAsFixed(0)} ${l10n.analyticsDwellUnit}'
              : null,
          subtitle:
              '${l10n.analyticsTurnoverRate}: ${ov?.turnoverRateToday.toStringAsFixed(1) ?? '—'}×',
          isLoading: state.isLoadingOverview,
        ),
      ],
    );
  }

  Color _getOccupancyColor(double occupancy) {
    if (occupancy > 0.9) return AppColors.redAccent;
    if (occupancy > 0.7) return AppColors.orangeAccent;
    return AppColors.primary;
  }

  Color _getStreamHealthColor(double pct) {
    if (pct >= 0.8) return Colors.green.shade700;
    if (pct >= 0.5) return Colors.orange.shade700;
    return AppColors.error;
  }
}

class _KpiCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final String subtitle;
  final bool isLoading;
  final Color? valueColor;

  const _KpiCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.isLoading,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isLoading)
              _shimmer()
            else ...[
              Text(
                value ?? '—',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? AppColors.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _shimmer() => Container(
    height: 24,
    width: 60,
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

class _OccupancyTrendCard extends ConsumerWidget {
  final AnalyticsState state;

  const _OccupancyTrendCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final periods = ['24h', '7d', '30d'];
    final selectedPeriod = state.selectedPeriod;

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.analyticsOccupancyTrend,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: periods.map((p) {
                      final isSelected = p == selectedPeriod;
                      final label = p == '24h'
                          ? l10n.analyticsPeriod24h
                          : p == '7d'
                          ? l10n.analyticsPeriod7d
                          : l10n.analyticsPeriod30d;
                      return GestureDetector(
                        onTap: () => ref
                            .read(analyticsProvider.notifier)
                            .selectPeriod(p),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _LegendDot(
                  color: AppColors.primary,
                  label: l10n.analyticsTodayLabel,
                ),
                const SizedBox(width: 16),
                _LegendDot(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  label: l10n.analyticsPriorLabel,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: state.isLoadingTrend
                  ? const Center(child: CircularProgressIndicator())
                  : state.trendError != null
                  ? _ErrorPlaceholder(error: state.trendError!)
                  : state.trend == null
                  ? _EmptyPlaceholder(label: l10n.analyticsNoData)
                  : _LineChart(state: state),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LineChart extends StatelessWidget {
  final AnalyticsState state;

  const _LineChart({required this.state});

  @override
  Widget build(BuildContext context) {
    final trend = state.trend!;
    final currentPts = trend.points;
    final compPts = trend.comparisonPoints;

    final maxVal = [
      ...currentPts.map((p) => p.occupancy),
      ...compPts.map((p) => p.occupancy),
    ].fold<double>(0.1, max);

    final currentSpots = [
      for (var i = 0; i < currentPts.length; i++)
        FlSpot(i.toDouble(), currentPts[i].occupancy),
    ];
    final compSpots = [
      for (var i = 0; i < compPts.length; i++)
        FlSpot(i.toDouble(), compPts[i].occupancy),
    ];

    final step = max(1, (currentPts.length / 6).ceil());

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: min(1.0, maxVal * 1.2),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 0.2,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 0.2,
              getTitlesWidget: (v, _) => Text(
                '${(v * 100).round()}%',
                style: TextStyle(fontSize: 9, color: AppColors.textSecondary),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: step.toDouble(),
              getTitlesWidget: (v, _) {
                final idx = v.toInt();
                if (idx < 0 || idx >= currentPts.length || idx % step != 0) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    currentPts[idx].label,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots.map((s) {
              return LineTooltipItem(
                '${(s.y * 100).toStringAsFixed(1)}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          if (compSpots.isNotEmpty)
            LineChartBarData(
              spots: compSpots,
              isCurved: true,
              color: AppColors.primary.withValues(alpha: 0.2),
              barWidth: 2,
              dotData: const FlDotData(show: false),
            ),
          LineChartBarData(
            spots: currentSpots,
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueTrendCard extends ConsumerWidget {
  final AnalyticsState state;

  const _RevenueTrendCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final ov = state.overview;
    final periods = ['24h', '7d', '30d'];
    final selectedPeriod = state.selectedPeriod;

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.analyticsRevenueTrend,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: periods.map((p) {
                      final isSelected = p == selectedPeriod;
                      final label = p == '24h'
                          ? l10n.analyticsPeriod24h
                          : p == '7d'
                          ? l10n.analyticsPeriod7d
                          : l10n.analyticsPeriod30d;
                      return GestureDetector(
                        onTap: () => ref
                            .read(analyticsProvider.notifier)
                            .selectPeriod(p),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _RevenueSummaryItem(
                  label: l10n.analyticsRevenueToday,
                  value: ov != null
                      ? '${l10n.analyticsRevenueUnit} ${ov.revenueToday.toStringAsFixed(0)}'
                      : '—',
                ),
                const SizedBox(width: 24),
                _RevenueSummaryItem(
                  label: l10n.analyticsRevenueMonth,
                  value: ov != null
                      ? '${l10n.analyticsRevenueUnit} ${ov.revenueMonth.toStringAsFixed(0)}'
                      : '—',
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: state.isLoadingTrend
                  ? const Center(child: CircularProgressIndicator())
                  : state.trendError != null
                  ? _ErrorPlaceholder(error: state.trendError!)
                  : state.trend == null
                  ? _EmptyPlaceholder(label: l10n.analyticsNoData)
                  : _RevenueBarChart(state: state),
            ),
          ],
        ),
      ),
    );
  }
}

class _RevenueSummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _RevenueSummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _RevenueBarChart extends StatelessWidget {
  final AnalyticsState state;

  const _RevenueBarChart({required this.state});

  @override
  Widget build(BuildContext context) {
    final trend = state.trend!;
    final pts = trend.points;

    final maxRev = pts.map((p) => p.revenue).fold<double>(1.0, max);
    final step = max(1, (pts.length / 6).ceil());

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxRev * 1.2,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.primary,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${context.l10n.analyticsRevenueUnit} ${rod.toY.toStringAsFixed(0)}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= pts.length || index % step != 0) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    pts[index].label,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  value >= 1000
                      ? '${(value / 1000).toStringAsFixed(1)}k'
                      : value.toStringAsFixed(0),
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: pts.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value.revenue,
                color: AppColors.primary,
                width: 12,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxRev * 1.2,
                  color: AppColors.surfaceVariant.withValues(alpha: 0.3),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _OperationalImpactRow extends StatelessWidget {
  final AnalyticsState state;

  const _OperationalImpactRow({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ov = state.overview;

    return Row(
      children: [
        Expanded(
          child: _ImpactMetricCard(
            icon: Icons.sync_rounded,
            label: l10n.analyticsTurnoverToday,
            value: ov != null
                ? '${ov.turnoverRateToday.toStringAsFixed(1)}×'
                : '—',
            subtitle: l10n.analyticsTurnoverRate,
            isLoading: state.isLoadingOverview,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ImpactMetricCard(
            icon: Icons.access_time_rounded,
            label: l10n.analyticsAvgDwell,
            value: ov != null
                ? '${ov.avgDwellTimeMinutes.toStringAsFixed(0)}m'
                : '—',
            subtitle: l10n.analyticsDwellUnit,
            isLoading: state.isLoadingOverview,
          ),
        ),
      ],
    );
  }
}

class _ImpactMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final bool isLoading;

  const _ImpactMetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (isLoading)
                    _shimmer()
                  else
                    Text(
                      value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmer() => Container(
    height: 20,
    width: 60,
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

class _AiHealthCard extends StatelessWidget {
  final AnalyticsState state;

  const _AiHealthCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final health = state.aiHealth;

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.analyticsAiHealth,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (state.isLoadingAiHealth)
              const Center(child: CircularProgressIndicator())
            else if (state.aiHealthError != null)
              _ErrorPlaceholder(error: state.aiHealthError!)
            else ...[
              _HealthRow(
                label: l10n.analyticsConfidenceMean,
                value: health?.avgConfidence ?? 0,
                displayText: health != null
                    ? '${(health.avgConfidence * 100).toStringAsFixed(1)}%'
                    : '—',
                subtitle:
                    '${health?.sampleCount ?? 0} ${l10n.analyticsSampleCount}',
              ),
              const SizedBox(height: 20),
              _HealthRow(
                label: l10n.analyticsCpuLoad,
                value: (health?.systemCpuPct ?? 0) / 100,
                displayText: health?.systemCpuPct != null
                    ? '${health!.systemCpuPct!.toStringAsFixed(1)}%'
                    : '—',
              ),
              const SizedBox(height: 20),
              _HealthRow(
                label: l10n.analyticsInferenceLatency,
                value: health?.inferenceLatencyMs != null
                    ? min(1.0, health!.inferenceLatencyMs! / 500)
                    : 0,
                displayText: health?.inferenceLatencyMs != null
                    ? '${health!.inferenceLatencyMs!.toStringAsFixed(0)} ${l10n.analyticsMsUnit}'
                    : '—',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HealthRow extends StatelessWidget {
  final String label;
  final double value;
  final String displayText;
  final String? subtitle;

  const _HealthRow({
    required this.label,
    required this.value,
    required this.displayText,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
            ),
            Text(
              displayText,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: AppColors.surfaceVariant,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  final String error;
  const _ErrorPlaceholder({required this.error});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: AppColors.error, fontSize: 12),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  final String label;
  const _EmptyPlaceholder({required this.label});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    );
  }
}
