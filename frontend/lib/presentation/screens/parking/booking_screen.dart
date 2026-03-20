import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
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
import 'package:parkflow/services/reservation_service.dart';
import 'package:parkflow/core/network/entities/slot_availability_response_entity.dart';
import 'package:parkflow/l10n/app_localizations.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    debugPrint('BookingScreen: initState - Setting up form listeners');

    form = FormGroup(
      {
        'vehicle': FormControl<int>(validators: [Validators.required]),
        'arrival_date': FormControl<DateTime>(
          value: DateTime.now(),
          validators: [Validators.required],
        ),
        'arrival_time': FormControl<DateTime>(
          value: DateTime.now().add(const Duration(minutes: 15)),
          validators: [Validators.required],
        ),
        'duration': FormControl<int>(
          value: 60,
          validators: [Validators.required],
        ),
        'slot_selection_mode': FormControl<String>(value: 'auto'),
        'selected_slot_id': FormControl<String>(),
        'payment_method': FormControl<String>(
          value: 'card',
          validators: [Validators.required],
        ),
      },
      validators: [Validators.delegate(_futureDateTimeValidator)],
    );

    form.valueChanges.listen((value) {
      debugPrint('BookingScreen: form.valueChanges emitted: $value');
      _onDataChanged();
    });
  }

  bool _isSlotAvailable = true;
  bool _isCheckingAvailability = false;
  bool _hasCheckedAvailability = false;
  String? _suggestedSlotId;
  Timer? _debounceTimer;

  static Map<String, dynamic>? _futureDateTimeValidator(
    AbstractControl<dynamic> control,
  ) {
    final group = control as FormGroup;
    final date = group.control('arrival_date').value as DateTime?;
    final time = group.control('arrival_time').value as DateTime?;

    if (date == null || time == null) return null;

    final combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (combined.isBefore(DateTime.now().add(const Duration(minutes: 1)))) {
      return {'pastDateTime': true};
    }

    return null;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onDataChanged() {
    setState(() {
      _hasCheckedAvailability = false;
      _isSlotAvailable = true;
      _suggestedSlotId = null;
    });

    _debounceCheckAvailability();
  }

  void _debounceCheckAvailability() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      _checkAvailability,
    );
  }

  Future<void> _checkAvailability() async {
    final mode = form.control('slot_selection_mode').value as String?;
    final slotId = form.control('selected_slot_id').value as String?;
    final date = form.control('arrival_date').value as DateTime?;
    final time = form.control('arrival_time').value as DateTime?;
    final duration = form.control('duration').value as int?;

    if (date == null || time == null || duration == null) return;
    if (mode == 'manual' && slotId == null) return;

    final startTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => _isCheckingAvailability = true);

    try {
      final lotId = ref.read(parkingProvider).lot?.id;
      if (lotId == null) throw Exception('No lot selected');

      final SlotAvailabilityResponseEntity response;
      if (mode == 'manual') {
        response = await ref
            .read(reservationServiceProvider)
            .checkSlotAvailability(
              slotId: slotId!,
              startTime: startTime,
              durationMinutes: duration,
            );
      } else {
        response = await ref
            .read(reservationServiceProvider)
            .checkLotAvailability(
              lotId: lotId,
              startTime: startTime,
              durationMinutes: duration,
            );
      }

      if (mounted) {
        setState(() {
          _isSlotAvailable = response.available;
          _isCheckingAvailability = false;
          _hasCheckedAvailability = true;
          _suggestedSlotId = response.slotId;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingAvailability = false;
          _isSlotAvailable = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parkingState = ref.watch(parkingProvider);
    final reservationState = ref.watch(reservationNotifierProvider);
    final user = ref.watch(authProvider).user;
    final lot = parkingState.lot;

    if (lot == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.bookASlotTitle)),
        body: Center(child: Text(context.l10n.noLotSelected)),
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
                    title: context.l10n.yourVehicleSection,
                    icon: Icons.directions_car,
                    isRequired: true,
                    action: user?.vehicles.isEmpty ?? true
                        ? TextButton(
                            onPressed: () =>
                                const AddVehicleRoute().push(context),
                            child: Text(context.l10n.addVehicleAction),
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  _buildVehiclePicker(user),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: context.l10n.timeWindowSection,
                    icon: Icons.access_time,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildDatePicker(context),
                  const SizedBox(height: 16),
                  _buildTimePickers(context),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: context.l10n.slotPreferenceSection,
                    icon: Icons.map_outlined,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildSlotPreference(parkingState),
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: context.l10n.paymentMethodSection,
                    icon: Icons.payment,
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentPicker(),
                  const SizedBox(height: 48),
                  _buildPriceSummary(lot.baseRate),
                  const SizedBox(height: 16),
                  _buildConflictCheckIndicator(),
                  const SizedBox(height: 24),
                  if (!_isSlotAvailable) ...[
                    _buildAvailabilityWarning(),
                    const SizedBox(height: 16),
                  ] else if (_hasCheckedAvailability &&
                      !_isCheckingAvailability) ...[
                    _buildAvailabilitySuccess(),
                    const SizedBox(height: 16),
                  ],
                  if (reservationState is AsyncError) ...[
                    _buildReservationError(reservationState.error!),
                    const SizedBox(height: 16),
                  ],
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      if (form.hasError('pastDateTime')) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildPastTimeWarning(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  _buildSubmitButton(reservationState.isLoading),
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
            Text(
              context.l10n.noVehiclesFound,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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

  Widget _buildDatePicker(BuildContext context) {
    return ReactiveValueListenableBuilder<DateTime>(
      formControlName: 'arrival_date',
      builder: (context, control, child) {
        return SizedBox(
          width: double.infinity,
          child: _PickerTile(
            label: context.l10n.arrivalDateLabel,
            isRequired: true,
            value: DateFormat(
              'EEEE, MMMM d, yyyy',
            ).format(control.value ?? DateTime.now()),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: control.value ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) {
                control.updateValue(date);
              }
            },
          ),
        );
      },
    );
  }

  IconData _getVehicleIcon(String type) {
    final t = type.toLowerCase();
    if (t.contains('car')) return Icons.directions_car_rounded;
    if (t.contains('bike') || t.contains('cycle')) {
      return Icons.pedal_bike_rounded;
    }
    if (t.contains('three') || t.contains('tuk')) {
      return Icons.electric_rickshaw_rounded;
    }
    if (t.contains('truck') || t.contains('van')) {
      return Icons.local_shipping_rounded;
    }
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
                label: context.l10n.arrivalTimeLabel,
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
                    final selectedDate =
                        form.control('arrival_date').value as DateTime? ??
                        DateTime.now();
                    control.updateValue(
                      DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
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
                label: context.l10n.durationLabel,
                isRequired: true,
                value: context.l10n.minutesDuration('${control.value ?? 60}'),
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
              Text(
                context.l10n.durationLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [30, 60, 120, 180, 240, 480].map((d) {
                  return ChoiceChip(
                    label: Text('$d ${context.l10n.minutesShort}'),
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
                label: context.l10n.smartSuggestionLabel,
                isSelected: form.control('slot_selection_mode').value == 'auto',
                onTap: () =>
                    form.control('slot_selection_mode').updateValue('auto'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ChoiceTile(
                label: context.l10n.manualSelectionLabel,
                isSelected:
                    form.control('slot_selection_mode').value == 'manual',
                onTap: () =>
                    form.control('slot_selection_mode').updateValue('manual'),
              ),
            ),
          ],
        ),
        if (form.control('slot_selection_mode').value == 'auto' &&
            _hasCheckedAvailability &&
            _isSlotAvailable &&
            _suggestedSlotId != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${context.l10n.smartSuggestionLabel}: $_suggestedSlotId',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
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
          debugPrint('BookingScreen: onSlotSelected - SlotId: ${slot.id}');
          if (!slot.isOccupied) {
            form.control('selected_slot_id').updateValue(slot.id);
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
            label: context.l10n.paymentMethodTypeCard,
            isSelected: form.control('payment_method').value == 'card',
            onTap: () => form.control('payment_method').updateValue('card'),
            icon: Icons.credit_card_outlined,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ChoiceTile(
            label: context.l10n.paymentMethodTypeCash,
            isSelected: form.control('payment_method').value == 'cash',
            onTap: () => form.control('payment_method').updateValue('cash'),
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
              Expanded(
                child: Text(
                  context.l10n.baseRateLabel,
                  style: TextStyle(color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
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
              Expanded(
                child: Text(
                  context.l10n.durationLabel,
                  style: TextStyle(color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
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
              Expanded(
                child: Text(
                  context.l10n.totalPriceLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
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

  Widget _buildConflictCheckIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(
            _isCheckingAvailability ? Icons.sync : Icons.info_outline,
            size: 14,
            color: _isCheckingAvailability
                ? AppColors.primary
                : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _isCheckingAvailability
                  ? context.l10n.verifyingAvailability
                  : context.l10n.conflictCheckHint,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySuccess() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.slotAvailableMessage,
              style: TextStyle(
                color: Colors.green,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityWarning() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.slotNotAvailableMessage,
              style: TextStyle(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationError(Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error.toString().replaceAll('Exception: ', ''),
              style: TextStyle(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastTimeWarning() {
    final AppLocalizations l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.history_toggle_off, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.pastTimeWarning,
              style: TextStyle(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final bool isFormValid =
            form.valid &&
            _hasCheckedAvailability &&
            !_isCheckingAvailability &&
            _isSlotAvailable;

        return AppPrimaryButton(
          label: context.l10n.confirmBookingAction,
          onPressed: isFormValid ? _submitBooking : null,
          isLoading: isLoading,
          width: double.infinity,
        );
      },
    );
  }

  Future<void> _submitBooking() async {
    final user = ref.read(authProvider).user;
    if (user == null) return;

    // Capture context variables to prevent "ref/context not available after unmount"
    final lotProvider = ref.read(parkingProvider);
    final notifier = ref.read(reservationNotifierProvider.notifier);

    try {
      final vehicleIndex = form.control('vehicle').value as int;
      final vehicle = user.vehicles[vehicleIndex];
      final date = form.control('arrival_date').value as DateTime;
      final time = form.control('arrival_time').value as DateTime;
      final duration = form.control('duration').value as int;

      final startTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      final paymentMethod = form.control('payment_method').value as String;
      final slotId = form.control('selected_slot_id').value as String?;

      final lotId = lotProvider.lot?.id;

      final reservation = await notifier.createReservation(
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
      }
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'BookingScreen: Error during submission');
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
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Spacer(),
        action ?? const SizedBox.shrink(),
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
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
