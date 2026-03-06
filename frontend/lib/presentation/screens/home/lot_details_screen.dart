import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';

class LotDetailsScreen extends ConsumerWidget {
  const LotDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingState = ref.watch(parkingProvider);
    final lot = parkingState.lot;

    if (lot == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(backgroundColor: AppColors.white, elevation: 0),
        body: const Center(child: Text('No lot selected')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
          lot.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context, parkingState)),
          if (parkingState.suggestions.isNotEmpty)
            SliverToBoxAdapter(child: _buildSuggestions(context, parkingState)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            sliver: parkingState.isLoading && parkingState.slots.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : _buildSlotGrid(context, parkingState),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ParkingState state) {
    final lot = state.lot!;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  lot.address,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _StatusBadge(isOpen: lot.isOpen),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric(
                context,
                Icons.local_parking,
                '${lot.totalSlots - (lot.totalSlots * lot.occupancy).toInt()}',
                context.l10n.available,
              ),
              Container(width: 1, height: 40, color: AppColors.outlineVariant),
              _buildMetric(
                context,
                Icons.layers_outlined,
                '${lot.totalSlots}',
                context.l10n.totalSlotsLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestions(BuildContext context, ParkingState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Top Recommended P-Spots',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.suggestions.map((s) {
                return Container(
                  margin: const EdgeInsets.only(right: 12, bottom: 8, top: 2),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.place,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.slotName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '~${s.distanceMeters.toStringAsFixed(1)}m away',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotGrid(BuildContext context, ParkingState state) {
    if (state.slots.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text('No slots available'),
          ),
        ),
      );
    }

    int maxCol = 0;
    int maxRow = 0;
    for (var slot in state.slots) {
      if (slot.logicalCol > maxCol) maxCol = slot.logicalCol;
      if (slot.logicalRow > maxRow) maxRow = slot.logicalRow;
    }

    final Map<String, ParkingSlotModel> gridMap = {};
    for (var slot in state.slots) {
      gridMap['${slot.logicalRow}_${slot.logicalCol}'] = slot;
    }

    return SliverToBoxAdapter(
      child: Container(
        height: (maxRow + 1) * 80.0 + (maxRow * 12.0) + 48.0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(24),
          minScale: 0.5,
          maxScale: 2.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: (maxCol + 1) * 80.0 + (maxCol * 12.0),
              height: (maxRow + 1) * 80.0 + (maxRow * 12.0),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: maxCol + 1,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: (maxRow + 1) * (maxCol + 1),
                itemBuilder: (context, index) {
                  final r = index ~/ (maxCol + 1);
                  final c = index % (maxCol + 1);
                  final slot = gridMap['${r}_$c'];

                  if (slot == null) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(
                            alpha: 0.2,
                          ),
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.not_interested,
                          size: 20,
                          color: AppColors.textSecondary.withValues(alpha: 0.3),
                        ),
                      ),
                    );
                  }

                  final isSuggestion = state.suggestions.any(
                    (s) => s.slotId == slot.id,
                  );

                  return Container(
                    decoration: BoxDecoration(
                      color: slot.isOccupied
                          ? AppColors.occupiedBackground
                          : isSuggestion
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.availableBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: slot.isOccupied
                            ? AppColors.occupiedBorder
                            : isSuggestion
                            ? AppColors.primary
                            : AppColors.availableBorder,
                        width: isSuggestion ? 2.5 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              slot.isOccupied
                                  ? Icons.directions_car
                                  : Icons.local_parking,
                              size: 28.0,
                              color: slot.isOccupied
                                  ? AppColors.occupiedText
                                  : isSuggestion
                                  ? AppColors.primary
                                  : AppColors.availableText,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              slot.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.3,
                                color: slot.isOccupied
                                    ? AppColors.occupiedTextDark
                                    : AppColors.availableTextDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOpen;

  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? AppColors.availableText : AppColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            isOpen ? context.l10n.statusOpen : context.l10n.statusClosed,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
