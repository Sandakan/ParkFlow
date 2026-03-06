import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';

import 'package:parkflow/presentation/notifiers/admin/admin_create_parking_lot_provider.dart';

import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';

class AdminCreateParkingLotScreen extends ConsumerStatefulWidget {
  const AdminCreateParkingLotScreen({super.key});

  @override
  ConsumerState<AdminCreateParkingLotScreen> createState() =>
      _AdminCreateParkingLotScreenState();
}

class _AdminCreateParkingLotScreenState
    extends ConsumerState<AdminCreateParkingLotScreen> {
  late final FormGroup form;

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
        value: '5.0',
        validators: [Validators.required, Validators.pattern(r'^\d*(\.\d+)?$')],
      ),
      'slotLength': FormControl<String>(
        value: '5.0',
        validators: [Validators.required, Validators.pattern(r'^\d*(\.\d+)?$')],
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
    final isLoading = ref.watch(adminCreateParkingLotProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          context.l10n.createLotTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            keyboardType: const TextInputType.numberWithOptions(
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
                            keyboardType: const TextInputType.numberWithOptions(
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
                            label: 'Slot Width (m)',
                            hintText: 'e.g. 5.0',
                            prefixIcon: Icons.width_full_outlined,
                            isRequired: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: LabeledReactiveTextField<String>(
                            formControlName: 'slotLength',
                            label: 'Slot Length (m)',
                            hintText: 'e.g. 5.0',
                            prefixIcon: Icons.height_outlined,
                            isRequired: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final l10n = context.l10n;
                              if (form.invalid) {
                                form.markAllAsTouched();
                                return;
                              }
                              try {
                                final request = CreateParkingLotRequest(
                                  name: form.control('name').value as String,
                                  address:
                                      form.control('address').value as String,
                                  latitude: double.parse(
                                    form.control('latitude').value as String,
                                  ),
                                  longitude: double.parse(
                                    form.control('longitude').value as String,
                                  ),
                                  totalSlots: int.parse(
                                    form.control('totalSlots').value as String,
                                  ),
                                  slotWidthMeters: double.parse(
                                    form.control('slotWidth').value as String,
                                  ),
                                  slotLengthMeters: double.parse(
                                    form.control('slotLength').value as String,
                                  ),
                                );
                                await ref
                                    .read(
                                      adminCreateParkingLotProvider.notifier,
                                    )
                                    .submit(request);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.lotCreatedSuccess),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  context.pop();
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              context.l10n.createButton,
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
