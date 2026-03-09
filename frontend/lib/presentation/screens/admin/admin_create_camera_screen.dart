import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/presentation/notifiers/parking_lots/parking_lots_notifier.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';

import 'package:parkflow/repositories/entities/parking/create_camera_request.dart';
import 'package:parkflow/presentation/notifiers/admin/admin_create_camera_provider.dart';

class AdminCreateCameraScreen extends ConsumerStatefulWidget {
  const AdminCreateCameraScreen({super.key});

  @override
  ConsumerState<AdminCreateCameraScreen> createState() =>
      _AdminCreateCameraScreenState();
}

class _AdminCreateCameraScreenState
    extends ConsumerState<AdminCreateCameraScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'rtspUrl': FormControl<String>(validators: [Validators.required]),
      'lotId': FormControl<String>(validators: [Validators.required]),
    });
    // Ensure parking lots are fetched so we can populate the dropdown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parkingLotsProvider.notifier).fetchLots();
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(adminCreateCameraProvider);

    final parkingLotsState = ref.watch(parkingLotsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          context.l10n.createCameraTitle,
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
                      label: context.l10n.cameraNameLabel,
                      hintText: context.l10n.cameraNameHint,
                      prefixIcon: Icons.videocam,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    LabeledReactiveTextField<String>(
                      formControlName: 'rtspUrl',
                      label: context.l10n.rtspUrlLabel,
                      hintText: context.l10n.rtspUrlHint,
                      prefixIcon: Icons.link,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    LabeledReactiveDropdownField<String>(
                      formControlName: 'lotId',
                      label: context.l10n.parkingLots,
                      hintText: context.l10n.selectParkingLotHint,
                      prefixIcon: Icons.local_parking,
                      isRequired: true,
                      items: parkingLotsState.lots.map((lot) {
                        return DropdownMenuItem(
                          value: lot.id,
                          child: Text(lot.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: isLoading || parkingLotsState.lots.isEmpty
                          ? null
                          : () async {
                              final l10n = context.l10n;
                              if (form.invalid) {
                                form.markAllAsTouched();
                                return;
                              }
                              try {
                                final request = CreateCameraRequest(
                                  name: form.control('name').value as String,
                                  rtspUrl:
                                      form.control('rtspUrl').value as String,
                                  lotId: form.control('lotId').value as String,
                                );
                                await ref
                                    .read(adminCreateCameraProvider.notifier)
                                    .submit(request);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.cameraCreatedSuccess),
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
