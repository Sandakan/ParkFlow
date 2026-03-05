import 'package:flutter/material.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class ParkingLotLayoutGrid extends StatelessWidget {
  final List<ParkingSlotModel> slots;
  final bool showSuggestions;
  final List<String> highlightedSlotIds;

  const ParkingLotLayoutGrid({
    required this.slots,
    this.showSuggestions = false,
    this.highlightedSlotIds = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int maxRow = slots.isEmpty ? 4 : 0;
    int maxCol = slots.isEmpty ? 4 : 0;

    for (var slot in slots) {
      if (slot.logicalRow > maxRow) maxRow = slot.logicalRow;
      if (slot.logicalCol > maxCol) maxCol = slot.logicalCol;
    }

    final Map<String, ParkingSlotModel> gridMap = {};
    for (var slot in slots) {
      gridMap['${slot.logicalRow}_${slot.logicalCol}'] = slot;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = maxCol + 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
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
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.grid_3x3,
                            size: 14,
                            color: Colors.grey.shade300,
                          ),
                          Text(
                            'R$r C$c',
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final isHighlighted = highlightedSlotIds.contains(slot.id);

                return Container(
                  decoration: BoxDecoration(
                    color: slot.isOccupied
                        ? AppColors.occupiedBackground
                        : isHighlighted
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.availableBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: slot.isOccupied
                          ? AppColors.occupiedBorder
                          : isHighlighted
                          ? AppColors.primary
                          : AppColors.availableBorder,
                      width: isHighlighted ? 2.0 : 1.0,
                    ),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            slot.isOccupied
                                ? Icons.directions_car
                                : Icons.local_parking,
                            size: 16.0,
                            color: slot.isOccupied
                                ? AppColors.occupiedText
                                : isHighlighted
                                ? AppColors.primary
                                : AppColors.availableText,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            slot.name,
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: slot.isOccupied
                                  ? AppColors.occupiedTextDark
                                  : AppColors.availableTextDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'R${slot.logicalRow} C${slot.logicalCol}',
                            style: TextStyle(
                              fontSize: 7,
                              color:
                                  (slot.isOccupied
                                          ? AppColors.occupiedTextDark
                                          : AppColors.availableTextDark)
                                      .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
