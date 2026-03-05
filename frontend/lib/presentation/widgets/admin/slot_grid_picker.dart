import 'package:flutter/material.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class SlotGridPicker extends StatelessWidget {
  final List<ParkingSlotModel> existingSlots;
  final int? selectedRow;
  final int? selectedCol;
  final ValueChanged<({int row, int col})> onCellSelected;

  const SlotGridPicker({
    required this.existingSlots,
    required this.selectedRow,
    required this.selectedCol,
    required this.onCellSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int maxRow = existingSlots.isEmpty ? 0 : 0;
    int maxCol = existingSlots.isEmpty ? 0 : 0;
    for (final slot in existingSlots) {
      if (slot.logicalRow > maxRow) maxRow = slot.logicalRow;
      if (slot.logicalCol > maxCol) maxCol = slot.logicalCol;
    }

    final totalRows = maxRow + 2;
    final totalCols = maxCol + 2;

    final usedKeys = <String>{
      for (final slot in existingSlots) '${slot.logicalRow}_${slot.logicalCol}',
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select grid position',
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        // Legend
        Row(
          children: [
            _LegendDot(color: Colors.grey.shade300, label: 'Used'),
            const SizedBox(width: 12),
            _LegendDot(
              color: AppColors.availableBackground,
              borderColor: AppColors.availableBorder,
              label: 'Empty',
            ),
            const SizedBox(width: 12),
            _LegendDot(
              color: AppColors.entranceBackground,
              borderColor: AppColors.entranceBorder,
              label: 'Entrance',
            ),
            const SizedBox(width: 12),
            _LegendDot(color: AppColors.primary, label: 'Selected'),
          ],
        ),
        const SizedBox(height: 10),
        // Row axis labels + grid
        _buildGrid(context, totalRows, totalCols, usedKeys),
      ],
    );
  }

  Widget _buildGrid(
    BuildContext context,
    int totalRows,
    int totalCols,
    Set<String> usedKeys,
  ) {
    const cellSize = 44.0;
    const labelSize = 24.0;

    final slotMap = <String, ParkingSlotModel>{
      for (final slot in existingSlots)
        '${slot.logicalRow}_${slot.logicalCol}': slot,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column header row
          Row(
            children: [
              SizedBox(width: labelSize),
              for (int c = 0; c < totalCols; c++)
                SizedBox(
                  width: cellSize,
                  child: Center(
                    child: Text(
                      'C$c',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          for (int r = 0; r < totalRows; r++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  // Row label
                  SizedBox(
                    width: labelSize,
                    child: Center(
                      child: Text(
                        'R$r',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  for (int c = 0; c < totalCols; c++)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: _buildCell(context, r, c, slotMap, cellSize),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCell(
    BuildContext context,
    int row,
    int col,
    Map<String, ParkingSlotModel> slotMap,
    double cellSize,
  ) {
    final key = '${row}_$col';
    final existingSlot = slotMap[key];
    final isUsed = existingSlot != null;
    final isSelected = selectedRow == row && selectedCol == col;

    Color bgColor;
    Color borderColor;
    Widget child;

    if (isUsed) {
      final isEntrance = existingSlot.slotType == 'entrance';
      bgColor = isEntrance
          ? AppColors.entranceBackground
          : Colors.grey.shade200;
      borderColor = isEntrance
          ? AppColors.entranceBorder
          : Colors.grey.shade300;
      child = Icon(
        isEntrance ? Icons.door_front_door : Icons.local_parking,
        size: 14,
        color: isEntrance ? AppColors.entranceText : Colors.grey.shade400,
      );
    } else if (isSelected) {
      bgColor = AppColors.primary;
      borderColor = AppColors.primary;
      child = const Icon(Icons.check, size: 16, color: Colors.white);
    } else {
      bgColor = AppColors.availableBackground;
      borderColor = AppColors.availableBorder;
      child = Text(
        '$row,$col',
        style: TextStyle(fontSize: 8, color: AppColors.textSecondary),
      );
    }

    return GestureDetector(
      onTap: isUsed ? null : () => onCellSelected((row: row, col: col)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor, width: isSelected ? 2.0 : 1.0),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final String label;

  const _LegendDot({
    required this.color,
    this.borderColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: borderColor ?? color),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
