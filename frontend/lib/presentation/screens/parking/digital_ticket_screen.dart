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
          final res = reservations.firstWhere((r) => r.id == reservationId);
          final slotName = ref
              .read(parkingProvider)
              .slots
              .firstWhere(
                (s) => s.id == res.slotId,
                orElse: () => throw 'Slot not found',
              )
              .name;
          final lot = ref.read(parkingProvider).lot!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 80,
                        )
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.easeOutBack)
                        .fadeIn(),
                    const SizedBox(height: 16),
                    const Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 48),
                    _buildTicketCard(res, lot, slotName),
                    const SizedBox(height: 32),
                    _buildNavigationButton(lot),
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
                      label: 'Arrival',
                      value: DateFormat('HH:mm').format(res.startTime),
                    ),
                    _TicketDetail(
                      label: 'Duration',
                      value: '${res.durationMinutes} min',
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildDashedLine(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Paid',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '₹ ${res.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: AppColors.primary,
                  ),
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

  Widget _buildNavigationButton(ParkingLotModel lot) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          final url =
              'https://www.google.com/maps/search/?api=1&query=${lot.latitude},${lot.longitude}';
          launchUrl(Uri.parse(url));
        },
        icon: const Icon(Icons.directions),
        label: const Text('Navigate to Lot'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.white, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
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
