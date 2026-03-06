import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class ParkingLotCard extends ConsumerWidget {
  final ParkingLotModel lot;
  final bool isSelected;
  final VoidCallback? onTap;

  const ParkingLotCard({
    super.key,
    required this.lot,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.outlineVariant, width: 2),
      ),
      child: GestureDetector(
        onTap:
            onTap ??
            () {
              ref.read(parkingProvider.notifier).selectLot(lot);
              const LotDetailsRoute().push(context);
            },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      lot.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _StatusBadge(isOpen: lot.isOpen),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                lot.address,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lot.distanceMeters != null
                        ? (lot.distanceMeters! >= 1000
                              ? context.l10n.kmAway(
                                  (lot.distanceMeters! / 1000).toStringAsFixed(
                                    1,
                                  ),
                                )
                              : context.l10n.metersAway(
                                  lot.distanceMeters!.toStringAsFixed(0),
                                ))
                        : '---',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(), // Use Spacer here to push the slots badge to the right
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      context.l10n.availableSlotsCount(
                        (lot.totalSlots -
                                (lot.totalSlots * lot.occupancy).toInt())
                            .toString(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
