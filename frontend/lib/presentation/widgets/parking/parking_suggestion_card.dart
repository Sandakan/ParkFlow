import 'package:flutter/material.dart';
import 'package:parkflow/core/network/entities/get_parking_suggestions_response_entity.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class ParkingSuggestionCard extends StatelessWidget {
  final ParkingSuggestionEntity suggestion;
  final VoidCallback? onTap;

  const ParkingSuggestionCard({
    super.key,
    required this.suggestion,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.place,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.slotName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '~${suggestion.distanceMeters.toStringAsFixed(1)}m away',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
