import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:parkflow/presentation/notifiers/parking/reservation_notifier.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/models/parking/parking_lot_model.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/models/parking/parking_slot_model.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class DigitalTicketScreen extends ConsumerWidget {
  final String reservationId;

  const DigitalTicketScreen({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationsAsync = ref.watch(reservationNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        foregroundColor: AppColors.white,
        title: const Text(
          'Digital Ticket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: reservationsAsync.when(
        data: (reservations) {
          final res = reservations.cast<ReservationModel?>().firstWhere(
            (r) => r?.id == reservationId,
            orElse: () => null,
          );
          if (res == null) {
            return const Center(
              child: Text(
                'Reservation not found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final parkingState = ref.watch(parkingProvider);
          final slot = parkingState.slots.cast<ParkingSlotModel?>().firstWhere(
            (s) => s?.id == res.slotId,
            orElse: () => null,
          );
          final slotName =
              slot?.name ?? 'S-${res.slotId.substring(res.slotId.length - 4)}';
          final lot = parkingState.lot;

          if (lot == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            );
          }

          final status = res.detailedStatus;
          final statusHeader = _getStatusHeader(context, status);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Icon(statusHeader.icon, color: statusHeader.color, size: 80)
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.easeOutBack)
                        .fadeIn(),
                    const SizedBox(height: 16),
                    Text(
                      statusHeader.title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 4),
                    Text(
                      statusHeader.subtitle,
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 48),
                    _buildTicketCard(context, res, lot, slotName),
                    const SizedBox(height: 32),
                    _buildActionButtons(context, lot),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.white),
        ),
        error: (e, s) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(
    BuildContext context,
    ReservationModel res,
    ParkingLotModel lot,
    String slotName,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  lot.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                Text(
                  lot.address,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: QrImageView(
                    data: res.qrCodeToken,
                    version: QrVersions.auto,
                    size: 200.0,
                    gapless: false,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _TicketDetail(label: 'Slot', value: slotName),
                    _TicketDetail(
                      label: 'Vehicle',
                      value: res.vehicle.plateNumber,
                    ),
                  ],
                ),
                const Divider(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _TicketDetail(
                      label: context.l10n.checkInLabel,
                      value: res.checkInTime != null
                          ? DateFormat(
                              'HH:mm',
                            ).format(res.checkInTime!.toLocal())
                          : '--:--',
                    ),
                    _TicketDetail(
                      label: context.l10n.checkOutLabel,
                      value: res.checkOutTime != null
                          ? DateFormat(
                              'HH:mm',
                            ).format(res.checkOutTime!.toLocal())
                          : '--:--',
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildDashedLine(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.originalPriceLabel,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'LKR ${res.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.finalPriceLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'LKR ${res.totalBilledPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.1, duration: 600.ms, curve: Curves.easeOut);
  }

  Widget _buildDashedLine() {
    return Row(
      children: List.generate(
        30,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 1,
            color: index.isEven ? AppColors.outlineVariant : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ParkingLotModel lot) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => const HomeRoute().go(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            label: const Text('Book Again'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.white, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              final url =
                  'https://www.google.com/maps/search/?api=1&query=${lot.latitude},${lot.longitude}';
              launchUrl(Uri.parse(url));
            },
            icon: const Icon(Icons.directions_outlined),
            label: const Text('Navigate'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.white, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _StatusHeader _getStatusHeader(
    BuildContext context,
    ReservationStatus status,
  ) {
    switch (status) {
      case ReservationStatus.upcoming:
        return _StatusHeader(
          icon: Icons.check_circle,
          color: Colors.green,
          title: context.l10n.ticketStatusConfirmed,
          subtitle: context.l10n.ticketSubtitleConfirmed,
        );
      case ReservationStatus.ongoing:
        return _StatusHeader(
          icon: Icons.timer,
          color: Colors.blue,
          title: context.l10n.ticketStatusOngoing,
          subtitle: context.l10n.ticketSubtitleOngoing,
        );
      case ReservationStatus.overstay:
        return _StatusHeader(
          icon: Icons.warning_amber_rounded,
          color: Colors.redAccent,
          title: context.l10n.ticketStatusOverstay,
          subtitle: context.l10n.ticketSubtitleOverstay,
        );
      case ReservationStatus.expired:
        return _StatusHeader(
          icon: Icons.history,
          color: Colors.orange,
          title: context.l10n.ticketStatusExpired,
          subtitle: context.l10n.ticketSubtitleExpired,
        );
      case ReservationStatus.noShow:
        return _StatusHeader(
          icon: Icons.person_off_rounded,
          color: Colors.orange,
          title: context.l10n.statusNoShow,
          subtitle: context.l10n.ticketSubtitleNoShow,
        );
      case ReservationStatus.completed:
        return _StatusHeader(
          icon: Icons.task_alt,
          color: Colors.green,
          title: context.l10n.ticketStatusCompleted,
          subtitle: context.l10n.ticketSubtitleCompleted,
        );
      case ReservationStatus.cancelled:
        return _StatusHeader(
          icon: Icons.cancel_outlined,
          color: Colors.redAccent,
          title: context.l10n.ticketStatusCancelled,
          subtitle: context.l10n.ticketSubtitleCancelled,
        );
    }
  }
}

class _StatusHeader {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  _StatusHeader({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });
}

class _TicketDetail extends StatelessWidget {
  final String label;
  final String value;

  const _TicketDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ],
    );
  }
}
