import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingState = ref.watch(parkingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.liveDashboard),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: context.l10n.logoutTooltip,
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),

      body: parkingState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : parkingState.error != null
          ? Center(
              child: Text(
                AppException.getLocalizedErrorMessage(
                  parkingState.error,
                  AppLocalizations.of(context),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(parkingProvider);
              },
              child: CustomScrollView(
                slivers: [
                  if (parkingState.suggestions.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildSuggestions(context, parkingState),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: _buildSlotGrid(context, parkingState),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSuggestions(BuildContext context, ParkingState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.suggestions.map((s) {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.place,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.slotName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '~${s.distanceMeters.toStringAsFixed(1)}m away',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
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
        child: Center(child: Text('No slots available')),
      );
    }

    // Determine grid bounds
    int maxRow = 0;
    int maxCol = 0;
    for (var slot in state.slots) {
      if (slot.logicalRow > maxRow) maxRow = slot.logicalRow;
      if (slot.logicalCol > maxCol) maxCol = slot.logicalCol;
    }

    // Create a matrix for slots
    final Map<String, ParkingSlotModel> gridMap = {};
    for (var slot in state.slots) {
      gridMap['${slot.logicalRow}_${slot.logicalCol}'] = slot;
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxCol + 1,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final r = index ~/ (maxCol + 1);
        final c = index % (maxCol + 1);
        final slot = gridMap['${r}_$c'];

        if (slot == null) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }

        final isSuggestion = state.suggestions.any((s) => s.slotId == slot.id);

        return Container(
          decoration: BoxDecoration(
            color: slot.isOccupied
                ? AppColors.occupiedBackground
                : isSuggestion
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.availableBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: slot.isOccupied
                  ? AppColors.occupiedBorder
                  : isSuggestion
                  ? AppColors.primary
                  : AppColors.availableBorder,
              width: isSuggestion ? 2.0 : 1.5,
            ),
            boxShadow: isSuggestion
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: InkWell(
            onTap: () {
              // Future: Show slot details
            },
            child: Stack(
              children: [
                if (isSuggestion)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Icon(Icons.star, color: AppColors.primary, size: 14),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        slot.isOccupied
                            ? Icons.directions_car
                            : Icons.local_parking,
                        size: 24.0,
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: slot.isOccupied
                              ? AppColors.occupiedTextDark
                              : AppColors.availableTextDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: (maxRow + 1) * (maxCol + 1)),
    );
  }
}
