import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/presentation/notifiers/parking/reservation_notifier.dart';
import 'package:parkflow/presentation/widgets/parking/rating_dialog.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;
  final bool isHorizontal;

  const ReservationCard({
    super.key,
    required this.reservation,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final detailedStatus = reservation.detailedStatus;
    final statusColor = _getStatusColor(detailedStatus);
    final statusText = _getStatusText(context, detailedStatus);

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dateFormat.format(reservation.startTime.toLocal()),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _StatusBadge(color: statusColor, text: statusText),
          ],
        ),
        SizedBox(height: isHorizontal ? 2 : 4),
        Text(
          timeFormat.format(reservation.startTime.toLocal()),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: isHorizontal ? 4 : 8),
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${reservation.lotName} | ${reservation.slotName}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: isHorizontal ? 8 : 12),
        Row(
          children: [
            const Icon(
              Icons.directions_car,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${_getVehicleTypeText(context, reservation.vehicle.type)} (${reservation.vehicle.plateNumber})',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: isHorizontal ? 4 : 8),
        Row(
          children: [
            const Icon(Icons.timer, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              context.l10n.durationHours(
                (reservation.durationMinutes ~/ 60).toString(),
                (reservation.durationMinutes % 60).toString(),
              ),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              context.l10n.lkrAmount(reservation.totalPrice.toStringAsFixed(0)),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        if (reservation.detailedStatus == ReservationStatus.completed &&
            !reservation.hasRating) ...[
          const SizedBox(height: 12),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => RatingDialog(
                        reservationId: reservation.id,
                        lotName: reservation.lotName,
                      ),
                    ).then((rated) {
                      if (rated == true) {
                        ref.invalidate(reservationNotifierProvider);
                      }
                    });
                  },
                  icon: const Icon(Icons.star_outline, size: 18),
                  label: Text(context.l10n.submitRating),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );

    return Container(
      width: isHorizontal ? 280 : double.infinity,
      margin: isHorizontal
          ? const EdgeInsets.only(right: 16)
          : const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.outlineVariant, width: 1.5),
        ),
        child: InkWell(
          onTap: () =>
              DigitalTicketRoute(reservationId: reservation.id).push(context),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(isHorizontal ? 16 : 20),
            child: cardContent,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.upcoming:
        return Colors.blue;
      case ReservationStatus.noShow:
        return Colors.orange;
      case ReservationStatus.ongoing:
        return Colors.green;
      case ReservationStatus.overstay:
      case ReservationStatus.expired:
        return Colors.red;
      case ReservationStatus.completed:
      case ReservationStatus.cancelled:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText(BuildContext context, ReservationStatus status) {
    switch (status) {
      case ReservationStatus.upcoming:
        return context.l10n.statusUpcoming;
      case ReservationStatus.noShow:
        return context.l10n.statusNoShow;
      case ReservationStatus.expired:
        return context.l10n.statusExpired;
      case ReservationStatus.ongoing:
        return context.l10n.statusOngoing;
      case ReservationStatus.overstay:
        return context.l10n.statusOverstay;
      case ReservationStatus.completed:
        return context.l10n.statusCompleted;
      case ReservationStatus.cancelled:
        return context.l10n.statusCancelled;
    }
  }

  String _getVehicleTypeText(BuildContext context, String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return context.l10n.vehicleTypeCar;
      case 'bike':
      case 'motorcycle':
        return context.l10n.vehicleTypeMotorcycle;
      case 'three-wheeler':
        return context.l10n.vehicleTypeThreeWheeler;
      case 'truck':
        return context.l10n.vehicleTypeTruck;
      default:
        return type;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final Color color;
  final String text;

  const _StatusBadge({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
