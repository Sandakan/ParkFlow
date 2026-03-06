import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

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
        title: Text(context.l10n.createLotTitle),
        backgroundColor: AppColors.white,
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
                    _buildTextField(
                      context: context,
                      formControlName: 'name',
                      label: context.l10n.lotNameLabel,
                      hint: context.l10n.lotNameHint,
                      icon: Icons.local_parking,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context: context,
                      formControlName: 'address',
                      label: context.l10n.lotAddressLabel,
                      hint: context.l10n.lotAddressHint,
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            context: context,
                            formControlName: 'latitude',
                            label: context.l10n.latitudeLabel,
                            hint: context.l10n.latitudeHint,
                            icon: Icons.explore_outlined,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            context: context,
                            formControlName: 'longitude',
                            label: context.l10n.longitudeLabel,
                            hint: context.l10n.longitudeHint,
                            icon: Icons.explore_outlined,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context: context,
                      formControlName: 'totalSlots',
                      label: context.l10n.totalSlotsLabel,
                      hint: context.l10n.totalSlotsHint,
                      icon: Icons.format_list_numbered,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            context: context,
                            formControlName: 'slotWidth',
                            label: 'Slot Width (m)',
                            hint: 'e.g. 5.0',
                            icon: Icons.width_full_outlined,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            context: context,
                            formControlName: 'slotLength',
                            label: 'Slot Length (m)',
                            hint: 'e.g. 5.0',
                            icon: Icons.height_outlined,
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

  Widget _buildTextField({
    required BuildContext context,
    required String formControlName,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ReactiveTextField<String>(
          formControlName: formControlName,
          keyboardType: keyboardType,
          validationMessages: {
            ValidationMessage.required: (error) => context.l10n.fieldRequired,
            ValidationMessage.pattern: (error) => context.l10n.invalidNumber,
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            prefixIcon: Icon(icon, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
