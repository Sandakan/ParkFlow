import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/services/reservation_service.dart';
import 'package:parkflow/core/network/entities/reservation_response_entity.dart';
import 'package:parkflow/models/parking/reservation_model.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AdminReservationsScreen extends ConsumerStatefulWidget {
  const AdminReservationsScreen({super.key});

  @override
  ConsumerState<AdminReservationsScreen> createState() =>
      _AdminReservationsScreenState();
}

class _AdminReservationsScreenState
    extends ConsumerState<AdminReservationsScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final code = barcodes.first.rawValue;
      if (code != null) {
        setState(() => _isProcessing = true);
        _handleScannedCode(code);
      }
    }
  }

  Future<void> _handleScannedCode(String token) async {
    try {
      final response = await ref
          .read(reservationServiceProvider)
          .scanReservationQr(token, confirm: false);
      if (!mounted) return;

      _showReservationDetails(response, token);
    } catch (e) {
      if (!mounted) return;
      _showScanError(e.toString());
    }
  }

  void _showScanError(String message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ScanErrorSheet(
        message: message,
        onDismiss: () {
          setState(() => _isProcessing = false);
        },
      ),
    ).then((_) {
      if (mounted) setState(() => _isProcessing = false);
    });
  }

  void _showReservationDetails(
    ReservationResponseEntity response,
    String qrToken,
  ) {
    final reservation = response.reservation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ReservationDetailsSheet(
        reservation: reservation,
        qrToken: qrToken,
        onProcessed: () {
          setState(() => _isProcessing = false);
        },
      ),
    ).then((_) {
      if (mounted) setState(() => _isProcessing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.reservations)),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                VisibilityDetector(
                  key: const Key('admin_reservations_scanner'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction == 0) {
                      _scannerController.stop();
                    } else if (visibilityInfo.visibleFraction > 0) {
                      _scannerController.start();
                    }
                  },
                  child: MobileScanner(
                    controller: _scannerController,
                    onDetect: _onDetect,
                  ),
                ),
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Scan Reservation QR Code',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Position the QR code within the frame to check-in or check-out.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReservationDetailsSheet extends ConsumerStatefulWidget {
  final ReservationModel reservation;
  final String qrToken;
  final VoidCallback onProcessed;

  const _ReservationDetailsSheet({
    required this.reservation,
    required this.qrToken,
    required this.onProcessed,
  });

  @override
  ConsumerState<_ReservationDetailsSheet> createState() =>
      _ReservationDetailsSheetState();
}

class _ReservationDetailsSheetState
    extends ConsumerState<_ReservationDetailsSheet> {
  String? _selectedPaymentMethod;
  bool _isConfirming = false;
  late ReservationModel _reservation;

  @override
  void initState() {
    super.initState();
    _reservation = widget.reservation;
    _selectedPaymentMethod = _reservation.paymentMethod;
  }

  Future<void> _handleConfirm() async {
    setState(() => _isConfirming = true);
    try {
      await ref.read(reservationServiceProvider).scanReservationQr(
        widget.qrToken,
        confirm: true,
        paymentMethod: _selectedPaymentMethod,
      );

      if (!mounted) return;

      Navigator.pop(context);
      widget.onProcessed();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Processed successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isConfirming = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCheckIn = _reservation.checkInTime == null;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCheckIn ? 'Check-in Preview' : 'Checkout Preview',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (isCheckIn ? Colors.blue : Colors.green).withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: (isCheckIn ? Colors.blue : Colors.green).withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: Text(
                  isCheckIn ? 'PENDING' : 'ACTIVE',
                  style: TextStyle(
                    color: isCheckIn ? Colors.blue : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _DetailRow(label: 'Vehicle', value: _reservation.vehicle.plateNumber),
          _DetailRow(
            label: 'Slot',
            value: '${_reservation.lotName} - ${_reservation.slotName}',
          ),
          _DetailRow(
            label: 'Start Time',
            value: formatter.format(_reservation.startTime.toLocal()),
          ),
          _DetailRow(
            label: 'End Time',
            value: formatter.format(_reservation.endTime.toLocal()),
          ),
          if (_reservation.checkInTime != null)
            _DetailRow(
              label: 'Checked-in At',
              value: formatter.format(_reservation.checkInTime!.toLocal()),
            ),
          const Divider(height: 32, thickness: 1),
          if (!isCheckIn) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Billed Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'LKR ${_reservation.totalBilledPrice}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _PaymentMethodButton(
                    label: 'Cash',
                    icon: Icons.money_rounded,
                    isSelected: _selectedPaymentMethod == 'cash',
                    onTap: () => setState(() => _selectedPaymentMethod = 'cash'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PaymentMethodButton(
                    label: 'Card',
                    icon: Icons.credit_card_rounded,
                    isSelected: _selectedPaymentMethod == 'card',
                    onTap: () => setState(() => _selectedPaymentMethod = 'card'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PaymentMethodButton(
                    label: 'Wallet',
                    icon: Icons.account_balance_wallet_rounded,
                    isSelected: _selectedPaymentMethod == 'wallet',
                    onTap: () => setState(() => _selectedPaymentMethod = 'wallet'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isConfirming ? null : _handleConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isConfirming
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    )
                  : Text(
                      isCheckIn ? 'Confirm Check-in' : 'Confirm Checkout',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanErrorSheet extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ScanErrorSheet({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Scanning Error',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message
                .replaceAll('Exception: ', '')
                .replaceAll('AppException: ', ''),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onDismiss();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
