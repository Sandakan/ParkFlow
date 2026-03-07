import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/presentation/notifiers/parking/parking_notifier.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/models/auth/user_model.dart';
import 'package:parkflow/presentation/states/parking/parking_state.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_layout.dart';
import 'package:parkflow/presentation/notifiers/parking/reservation_notifier.dart';
import 'package:intl/intl.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/presentation/widgets/common/app_buttons.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  bool _isSubmitting = false;
  final form = fb.group({
    'vehicle': FormControl<int>(validators: [Validators.required]),
    'arrival_time': FormControl<DateTime>(
      value: DateTime.now().add(const Duration(minutes: 15)),
      validators: [Validators.required],
    ),
    'duration': FormControl<int>(value: 60, validators: [Validators.required]),
    'slot_selection_mode': FormControl<String>(value: 'auto'),
    'selected_slot_id': FormControl<String>(),
    'payment_method': FormControl<String>(
      value: 'card',
      validators: [Validators.required],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parkingState = ref.watch(parkingProvider);
    final user = ref.watch(authProvider).user;
    final lot = parkingState.lot;

    if (lot == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Book a Slot')),
        body: const Center(child: Text('No lot selected')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        title: Column(
          children: [
            Text(
              lot.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              lot.address,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                    title: 'Your Vehicle',
                    icon: Icons.directions_car,
                    isRequired: true,
                    action: user?.vehicles.isEmpty ?? true
                        ? TextButton(
                            onPressed: () =>
                                const AddVehicleRoute().push(context),
                            child: const Text('Add Vehicle'),
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  _buildVehiclePicker(user),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Time Window',
                    icon: Icons.access_time,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTimePickers(context),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Slot Preference',
                    icon: Icons.map_outlined,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildSlotPreference(parkingState),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: 'Payment Method',
                    icon: Icons.payment,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentPicker(),
                  const SizedBox(height: 48),
                  _buildPriceSummary(lot.pricePerHour),
                  const SizedBox(height: 24),
                  _buildSubmitButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehiclePicker(UserModel? user) {
    if (user == null || user.vehicles.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 48,
              color: AppColors.outlineVariant,
            ),
            const SizedBox(height: 16),
            const Text(
              'No vehicles found',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Add a vehicle to proceed with booking',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ReactiveValueListenableBuilder<int>(
      formControlName: 'vehicle',
      builder: (context, control, child) {
        return SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: user.vehicles.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final v = user.vehicles[index];
              final isSelected = control.value == index;
              return GestureDetector(
                onTap: () => control.updateValue(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 180,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.outlineVariant,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    spacing: 12,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.white.withValues(alpha: 0.2)
                              : AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getVehicleIcon(v.type),
                          color: isSelected
                              ? AppColors.white
                              : AppColors.primary,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              v.plateNumber,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              v.type.toUpperCase(),
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.white.withValues(alpha: 0.8)
                                    : AppColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  IconData _getVehicleIcon(String type) {
    final t = type.toLowerCase();
    if (t.contains('car')) return Icons.directions_car_rounded;
    if (t.contains('bike') || t.contains('cycle'))
      return Icons.pedal_bike_rounded;
    if (t.contains('three') || t.contains('tuk'))
      return Icons.electric_rickshaw_rounded;
    if (t.contains('truck') || t.contains('van'))
      return Icons.local_shipping_rounded;
    return Icons.directions_bus_rounded;
  }

  Widget _buildTimePickers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ReactiveValueListenableBuilder<DateTime>(
            formControlName: 'arrival_time',
            builder: (context, control, child) {
              return _PickerTile(
                label: 'Arrival Time',
                isRequired: true,
                value: DateFormat(
                  'HH:mm',
                ).format(control.value ?? DateTime.now()),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      control.value ?? DateTime.now(),
                    ),
                  );
                  if (time != null) {
                    final now = DateTime.now();
                    control.updateValue(
                      DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ReactiveValueListenableBuilder<int>(
            formControlName: 'duration',
            builder: (context, control, child) {
              return _PickerTile(
                label: 'Duration',
                isRequired: true,
                value: '${control.value} min',
                onTap: () {
                  _showDurationPicker(context, control as FormControl<int>);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showDurationPicker(BuildContext context, FormControl<int> control) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Duration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [30, 60, 120, 180, 240, 480].map((d) {
                  return ChoiceChip(
                    label: Text('$d min'),
                    selected: control.value == d,
                    onSelected: (selected) {
                      if (selected) {
                        control.updateValue(d);
                        context.pop();
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlotPreference(ParkingState parkingState) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ChoiceTile(
                label: 'Smart Suggestion',
                isSelected: form.control('slot_selection_mode').value == 'auto',
                onTap: () => setState(
                  () => form.control('slot_selection_mode').updateValue('auto'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ChoiceTile(
                label: 'Manual Selection',
                isSelected:
                    form.control('slot_selection_mode').value == 'manual',
                onTap: () => setState(
                  () =>
                      form.control('slot_selection_mode').updateValue('manual'),
                ),
              ),
            ),
          ],
        ),
        if (form.control('slot_selection_mode').value == 'manual')
          ...?_buildManualSlotLayout(parkingState),
      ],
    );
  }

  List<Widget>? _buildManualSlotLayout(ParkingState parkingState) {
    return [
      const SizedBox(height: 24),
      ParkingLotLayout(
        slots: parkingState.slots,
        suggestions: parkingState.suggestions,
        isLoading: parkingState.isLoading,
        selectedSlotId: form.control('selected_slot_id').value as String?,
        onSlotSelected: (slot) {
          if (!slot.isOccupied) {
            setState(
              () => form.control('selected_slot_id').updateValue(slot.id),
            );
          }
        },
      ),
    ];
  }

  Widget _buildPaymentPicker() {
    return Row(
      children: [
        Expanded(
          child: _ChoiceTile(
            label: 'Card',
            isSelected: form.control('payment_method').value == 'card',
            onTap: () => setState(
              () => form.control('payment_method').updateValue('card'),
            ),
            icon: Icons.credit_card_outlined,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ChoiceTile(
            label: 'Cash',
            isSelected: form.control('payment_method').value == 'cash',
            onTap: () => setState(
              () => form.control('payment_method').updateValue('cash'),
            ),
            icon: Icons.money,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSummary(double pricePerHour) {
    final duration = form.control('duration').value as int;
    final totalPrice = (pricePerHour / 60) * duration;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Base Rate',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Text(
                'LKR ${pricePerHour.toStringAsFixed(2)}/hr',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Text(
                '$duration min',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                'LKR ${totalPrice.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return AppPrimaryButton(
      label: 'Confirm Booking',
      isLoading: _isSubmitting,
      onPressed: form.valid ? _submitBooking : null,
    );
  }

  Future<void> _submitBooking() async {
    final user = ref.read(authProvider).user;
    if (user == null) return;

    setState(() => _isSubmitting = true);

    try {
      final vehicleIndex = form.control('vehicle').value as int;
      final vehicle = user.vehicles[vehicleIndex];
      final startTime = form.control('arrival_time').value as DateTime;
      final duration = form.control('duration').value as int;
      final paymentMethod = form.control('payment_method').value as String;
      final slotId = form.control('selected_slot_id').value as String?;

      final lotId = ref.read(parkingProvider).lot?.id;

      final reservation = await ref
          .read(reservationNotifierProvider.notifier)
          .createReservation(
            slotId: slotId ?? 'auto',
            lotId: lotId,
            vehicle: vehicle,
            startTime: startTime,
            durationMinutes: duration,
            paymentMethod: paymentMethod,
          );

      if (!mounted) return;

      if (reservation != null) {
        DigitalTicketRoute(reservationId: reservation.id).go(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create reservation. Please try again.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? action;
  final bool isRequired;

  const _SectionHeader({
    required this.title,
    required this.icon,
    this.action,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            children: [
              TextSpan(text: title),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

class _PickerTile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isRequired;

  const _PickerTile({
    required this.label,
    required this.value,
    required this.onTap,
    this.isRequired = false,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                children: [
                  TextSpan(text: label),
                  if (isRequired)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const _ChoiceTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
