import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lot_layout_notifier.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_layout_grid.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/routes/router_provider.dart';

class ParkingLotLayoutSheet extends ConsumerWidget {
  final ParkingLotModel lot;
  final bool isSheet;

  const ParkingLotLayoutSheet({
    required this.lot,
    this.isSheet = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutState = ref.watch(parkingLotLayoutProvider(lot.id));

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSheet ? 24 : 0,
        vertical: isSheet ? 20 : 0,
      ),
      constraints: isSheet
          ? BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8)
          : null,
      decoration: isSheet
          ? const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            )
          : null,
      child: Column(
        mainAxisSize: isSheet ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (isSheet) ...[
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
          ],
          if (isSheet)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lot.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.l10n.currentOccupancyLayout,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (isSheet) Navigator.pop(context);
                        AdminEditParkingLotRoute(lot.id).go(context);
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.primary,
                      ),
                      tooltip: context.l10n.editLotTitle,
                    ),
                    if (isSheet)
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 24),
          if (layoutState.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (layoutState.error != null)
            Center(child: Text(layoutState.error.toString()))
          else
            Flexible(
              child: SingleChildScrollView(
                child: ParkingLotLayoutGrid(
                  slots: layoutState.slots,
                  highlightedSlotIds: layoutState.suggestions
                      .map((s) => s.slotId)
                      .toList(),
                ),
              ),
            ),
          const SizedBox(height: 24),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                color: AppColors.availableBackground,
                borderColor: AppColors.availableBorder,
                label: context.l10n.available,
              ),
              const SizedBox(width: 16),
              _LegendItem(
                color: AppColors.occupiedBackground,
                borderColor: AppColors.occupiedBorder,
                label: context.l10n.occupied,
              ),
              const SizedBox(width: 16),
              _LegendItem(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderColor: AppColors.primary,
                label: 'Optimal',
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String label;

  const _LegendItem({
    required this.color,
    required this.borderColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
