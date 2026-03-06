import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lot_layout_notifier.dart';
import 'package:parkflow/presentation/widgets/parking/parking_lot_layout_grid.dart';
import 'package:parkflow/repositories/entities/parking/update_parking_lot_request.dart';
import 'package:parkflow/presentation/notifiers/admin/admin_edit_parking_lot_provider.dart';

class AdminEditParkingLotScreen extends ConsumerStatefulWidget {
  final String lotId;
  const AdminEditParkingLotScreen({super.key, required this.lotId});

  @override
  ConsumerState<AdminEditParkingLotScreen> createState() =>
      _AdminEditParkingLotScreenState();
}

class _AdminEditParkingLotScreenState
    extends ConsumerState<AdminEditParkingLotScreen> {
  late final FormGroup form;
  bool _formInitialized = false;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'address': FormControl<String>(validators: [Validators.required]),
      'latitude': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(r'^-?[0-9]\d*(\.\d+)?$'),
        ],
      ),
      'longitude': FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(r'^-?[0-9]\d*(\.\d+)?$'),
        ],
      ),
      'totalSlots': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d+$')],
      ),
      'slotWidth': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d*(\.\d+)?$')],
      ),
      'slotLength': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d*(\.\d+)?$')],
      ),
      'entranceRow': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d+$')],
      ),
      'entranceCol': FormControl<String>(
        validators: [Validators.required, Validators.pattern(r'^\d+$')],
      ),
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editLotState = ref.watch(adminEditParkingLotProvider(widget.lotId));
    final isLoading = editLotState.isLoading;
    final isUpdating = editLotState.isUpdating;

    ref.listen(adminEditParkingLotProvider(widget.lotId), (prev, next) {
      if (next.lot != null && !_formInitialized) {
        final lot = next.lot!;
        form.patchValue({
          'name': lot.name,
          'address': lot.address,
          'latitude': lot.latitude.toString(),
          'longitude': lot.longitude.toString(),
          'totalSlots': lot.totalSlots.toString(),
          'slotWidth': (lot.slotWidthMeters ?? 5.0).toString(),
          'slotLength': (lot.slotLengthMeters ?? 5.0).toString(),
          'entranceRow':
              (lot.entranceLogicalLocations?.isNotEmpty == true
                      ? lot.entranceLogicalLocations![0][0]
                      : 0)
                  .toString(),
          'entranceCol':
              (lot.entranceLogicalLocations?.isNotEmpty == true
                      ? lot.entranceLogicalLocations![0][1]
                      : 0)
                  .toString(),
        });
        _formInitialized = true;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          context.l10n.editLotTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        centerTitle: false,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: isLoading || isUpdating
                ? null
                : () async {
                    final l10n = context.l10n;
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.deleteLotConfirmTitle),
                        content: Text(l10n.deleteLotConfirmMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(l10n.cancelButton),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.error,
                            ),
                            child: Text(l10n.deleteButton),
                          ),
                        ],
                      ),
                    );
                    if (confirmed != true) return;
                    if (!context.mounted) return;
                    try {
                      await ref
                          .read(
                            adminEditParkingLotProvider(widget.lotId).notifier,
                          )
                          .deleteLot();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.lotDeletedSuccess),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppException.getLocalizedErrorMessage(e, l10n),
                            ),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      }
                    }
                  },
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            tooltip: context.l10n.deleteLot,
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: ReactiveForm(
                      formGroup: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LabeledReactiveTextField<String>(
                            formControlName: 'name',
                            label: context.l10n.lotNameLabel,
                            hintText: context.l10n.lotNameHint,
                            prefixIcon: Icons.local_parking,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16),
                          LabeledReactiveTextField<String>(
                            formControlName: 'address',
                            label: context.l10n.lotAddressLabel,
                            hintText: context.l10n.lotAddressHint,
                            prefixIcon: Icons.location_on_outlined,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'latitude',
                                  label: context.l10n.latitudeLabel,
                                  hintText: context.l10n.latitudeHint,
                                  prefixIcon: Icons.explore_outlined,
                                  isRequired: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: true,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'longitude',
                                  label: context.l10n.longitudeLabel,
                                  hintText: context.l10n.longitudeHint,
                                  prefixIcon: Icons.explore_outlined,
                                  isRequired: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: true,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          LabeledReactiveTextField<String>(
                            formControlName: 'totalSlots',
                            label: context.l10n.totalSlotsLabel,
                            hintText: context.l10n.totalSlotsHint,
                            prefixIcon: Icons.format_list_numbered,
                            keyboardType: TextInputType.number,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'slotWidth',
                                  label: context.l10n.slotWidthLabel,
                                  hintText: 'e.g. 5.0',
                                  prefixIcon: Icons.width_full_outlined,
                                  isRequired: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'slotLength',
                                  label: context.l10n.slotLengthLabel,
                                  hintText: 'e.g. 5.0',
                                  prefixIcon: Icons.height_outlined,
                                  isRequired: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'entranceRow',
                                  label:
                                      '${context.l10n.entranceCoordsLabel} (${context.l10n.rowLabel})',
                                  hintText: '0',
                                  prefixIcon: Icons.door_front_door_outlined,
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: LabeledReactiveTextField<String>(
                                  formControlName: 'entranceCol',
                                  label:
                                      '${context.l10n.entranceCoordsLabel} (${context.l10n.colLabel})',
                                  hintText: '0',
                                  prefixIcon: Icons.door_front_door_outlined,
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            context.l10n.currentOccupancyLayout,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Consumer(
                            builder: (context, ref, child) {
                              final layoutState = ref.watch(
                                parkingLotLayoutProvider(widget.lotId),
                              );
                              if (layoutState.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (layoutState.slots.isEmpty) {
                                return Center(
                                  child: Text(
                                    context.l10n.noSlotsDefinedMessage,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                );
                              }
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 300,
                                ),
                                child: SingleChildScrollView(
                                  child: ParkingLotLayoutGrid(
                                    slots: layoutState.slots,
                                    highlightedSlotIds: layoutState.suggestions
                                        .map((s) => s.slotId)
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: isUpdating
                                ? null
                                : () async {
                                    final l10n = context.l10n;
                                    if (form.invalid) {
                                      form.markAllAsTouched();
                                      return;
                                    }
                                    try {
                                      final request = UpdateParkingLotRequest(
                                        name:
                                            form.control('name').value
                                                as String,
                                        address:
                                            form.control('address').value
                                                as String,
                                        latitude: double.parse(
                                          form.control('latitude').value
                                              as String,
                                        ),
                                        longitude: double.parse(
                                          form.control('longitude').value
                                              as String,
                                        ),
                                        totalSlots: int.parse(
                                          form.control('totalSlots').value
                                              as String,
                                        ),
                                        slotWidthMeters: double.parse(
                                          form.control('slotWidth').value
                                              as String,
                                        ),
                                        slotLengthMeters: double.parse(
                                          form.control('slotLength').value
                                              as String,
                                        ),
                                        entranceLogicalLocations: [
                                          [
                                            int.parse(
                                              form.control('entranceRow').value
                                                  as String,
                                            ),
                                            int.parse(
                                              form.control('entranceCol').value
                                                  as String,
                                            ),
                                          ],
                                        ],
                                      );
                                      await ref
                                          .read(
                                            adminEditParkingLotProvider(
                                              widget.lotId,
                                            ).notifier,
                                          )
                                          .submit(request);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              l10n.lotUpdatedSuccess,
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              AppException.getLocalizedErrorMessage(
                                                e,
                                                l10n,
                                              ),
                                            ),
                                            backgroundColor: AppColors.error,
                                          ),
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                            ),
                            child: isUpdating
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    context.l10n.updateButton,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
