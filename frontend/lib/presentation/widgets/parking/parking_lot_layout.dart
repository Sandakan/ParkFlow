import 'package:flutter/material.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class ParkingLotLayout extends StatelessWidget {
  final List<ParkingSlotModel> slots;
  final List<dynamic> suggestions;
  final bool isLoading;

  const ParkingLotLayout({
    super.key,
    required this.slots,
    required this.suggestions,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && slots.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (slots.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Text(
            'No updates yet. Connecting to live stream...',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    int maxCol = 0, maxRow = 0;
    for (var slot in slots) {
      if (slot.logicalCol > maxCol) maxCol = slot.logicalCol;
      if (slot.logicalRow > maxRow) maxRow = slot.logicalRow;
    }

    final Map<String, ParkingSlotModel> gridMap = {};
    for (var slot in slots) {
      gridMap['${slot.logicalRow}_${slot.logicalCol}'] = slot;
    }

    return SizedBox(
      height: 500,
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 24,
        ),
        minScale: 0.1,
        maxScale: 2.5,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: SizedBox(
            width: (maxCol + 1) * 90.0 + (maxCol * 12.0),
            height: (maxRow + 1) * 120.0 + (maxRow * 12.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: maxCol + 1,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemCount: (maxRow + 1) * (maxCol + 1),
              itemBuilder: (context, index) {
                final r = index ~/ (maxCol + 1);
                final c = index % (maxCol + 1);
                final slot = gridMap['${r}_$c'];

                if (slot == null) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.block,
                        size: 32,
                        color: AppColors.textSecondary.withValues(alpha: 0.3),
                      ),
                    ),
                  );
                }

                final isSuggestion = suggestions.any(
                  (s) => s.slotId == slot.id,
                );

                return _SlotWidget(slot: slot, isSuggestion: isSuggestion);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SlotWidget extends StatelessWidget {
  final ParkingSlotModel slot;
  final bool isSuggestion;

  const _SlotWidget({required this.slot, required this.isSuggestion});

  @override
  Widget build(BuildContext context) {
    final bgColor = slot.isOccupied
        ? AppColors.occupiedBackground
        : isSuggestion
        ? AppColors.primary.withValues(alpha: 0.08)
        : AppColors.availableBackground;

    final borderColor = slot.isOccupied
        ? AppColors.occupiedBorder
        : isSuggestion
        ? AppColors.primary
        : AppColors.availableBorder;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isSuggestion ? 2.5 : 1.5),
        boxShadow: isSuggestion
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            slot.isOccupied ? Icons.directions_car : Icons.local_parking,
            size: 32,
            color: slot.isOccupied
                ? AppColors.occupiedText
                : isSuggestion
                ? AppColors.primary
                : AppColors.availableText,
          ),
          const SizedBox(height: 8),
          Text(
            slot.name,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          if (isSuggestion)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'TOP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
