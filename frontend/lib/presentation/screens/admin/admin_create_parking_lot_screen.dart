import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/repositories/entities/parking/create_parking_lot_request.dart';
import 'package:parkflow/services/parking_service.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class AdminCreateParkingLotScreen extends ConsumerStatefulWidget {
  const AdminCreateParkingLotScreen({super.key});

  @override
  ConsumerState<AdminCreateParkingLotScreen> createState() =>
      _AdminCreateParkingLotScreenState();
}

class _AdminCreateParkingLotScreenState
    extends ConsumerState<AdminCreateParkingLotScreen> {
  bool _isLoading = false;

  late final FormGroup form = fb.group({
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
  });

  Future<void> _submit() async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = CreateParkingLotRequest(
        name: form.control('name').value as String,
        address: form.control('address').value as String,
        latitude: double.parse(form.control('latitude').value as String),
        longitude: double.parse(form.control('longitude').value as String),
        totalSlots: int.parse(form.control('totalSlots').value as String),
      );

      await ref.read(parkingServiceProvider).createParkingLot(request);
      await ref.read(parkingLotsProvider.notifier).fetchLots();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.lotCreatedSuccess),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppException.getLocalizedErrorMessage(e, context.l10n),
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      formControlName: 'name',
                      label: context.l10n.lotNameLabel,
                      hint: context.l10n.lotNameHint,
                      icon: Icons.local_parking,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
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
                      formControlName: 'totalSlots',
                      label: context.l10n.totalSlotsLabel,
                      hint: context.l10n.totalSlotsHint,
                      icon: Icons.format_list_numbered,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
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
