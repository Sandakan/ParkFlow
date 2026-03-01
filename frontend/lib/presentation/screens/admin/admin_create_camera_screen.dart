import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/services/camera_service.dart';
import 'package:parkflow/presentation/notifiers/cameras/cameras_notifier.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class AdminCreateCameraScreen extends ConsumerStatefulWidget {
  const AdminCreateCameraScreen({super.key});

  @override
  ConsumerState<AdminCreateCameraScreen> createState() =>
      _AdminCreateCameraScreenState();
}

class _AdminCreateCameraScreenState
    extends ConsumerState<AdminCreateCameraScreen> {
  bool _isLoading = false;

  late final FormGroup form = fb.group({
    'name': FormControl<String>(validators: [Validators.required]),
    'rtspUrl': FormControl<String>(validators: [Validators.required]),
    'lotId': FormControl<String>(validators: [Validators.required]),
  });

  @override
  void initState() {
    super.initState();
    // Ensure parking lots are fetched so we can populate the dropdown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parkingLotsProvider.notifier).fetchLots();
    });
  }

  Future<void> _submit() async {
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = CreateCameraRequest(
        name: form.control('name').value as String,
        rtspUrl: form.control('rtspUrl').value as String,
        lotId: form.control('lotId').value as String,
      );

      await ref.read(cameraServiceProvider).createCamera(request);
      await ref.read(camerasProvider.notifier).refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.cameraCreatedSuccess),
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
    final parkingLotsState = ref.watch(parkingLotsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(context.l10n.createCameraTitle),
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
                      label: context.l10n.cameraNameLabel,
                      hint: context.l10n.cameraNameHint,
                      icon: Icons.videocam,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      formControlName: 'rtspUrl',
                      label: context.l10n.rtspUrlLabel,
                      hint: context.l10n.rtspUrlHint,
                      icon: Icons.link,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.parkingLots, // Use "Lots" as label
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ReactiveDropdownField<String>(
                          formControlName: 'lotId',
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                context.l10n.fieldRequired,
                          },
                          decoration: InputDecoration(
                            hintText: context.l10n.selectParkingLotHint,
                            prefixIcon: Icon(
                              Icons.local_parking,
                              color: AppColors.textSecondary,
                            ),
                            filled: true,
                            fillColor: AppColors.surfaceVariant.withValues(
                              alpha: 0.5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.error,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.error,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          items: parkingLotsState.lots.map((lot) {
                            return DropdownMenuItem(
                              value: lot.id,
                              child: Text(lot.name),
                            );
                          }).toList(),
                          hint: parkingLotsState.isLoading
                              ? const Text('Loading...')
                              : const Text('Select Parking Lot'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading || parkingLotsState.lots.isEmpty
                          ? null
                          : _submit,
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
