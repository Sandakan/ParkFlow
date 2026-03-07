import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';
import 'package:parkflow/presentation/notifiers/profile/vehicle_notifier.dart';
import 'package:parkflow/presentation/widgets/common/app_buttons.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final form = FormGroup({
    'plate_number': FormControl<String>(validators: [Validators.required]),
    'type': FormControl<String>(
      value: 'car',
      validators: [Validators.required],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicleState = ref.watch(vehicleProvider);

    final errorMessage = vehicleState.error != null
        ? AppException.getLocalizedErrorMessage(
            vehicleState.error!,
            AppLocalizations.of(context),
          )
        : null;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Add New Vehicle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabeledReactiveTextField<String>(
                    label: 'License Plate Number',
                    formControlName: 'plate_number',
                    hintText: 'e.g. ABC 1234',
                    prefixIcon: Icons.badge_outlined,
                    textCapitalization: TextCapitalization.characters,
                    isRequired: true,
                    onChanged: (_) {
                      if (vehicleState.error != null) {
                        ref.read(vehicleProvider.notifier).clearError();
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  LabeledReactiveDropdownField<String>(
                    label: 'Vehicle Type',
                    formControlName: 'type',
                    prefixIcon: Icons.category_outlined,
                    isRequired: true,
                    items: const [
                      DropdownMenuItem(value: 'car', child: Text('Car')),
                      DropdownMenuItem(
                        value: 'bike',
                        child: Text('Motorcycle/Bike'),
                      ),
                      DropdownMenuItem(
                        value: 'three-wheeler',
                        child: Text('Three-Wheeler'),
                      ),
                      DropdownMenuItem(
                        value: 'truck',
                        child: Text('Truck/Van'),
                      ),
                    ],
                  ),

                  if (errorMessage != null) ...[
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.error.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: theme.colorScheme.error,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return AppPrimaryButton(
                        label: 'Add Vehicle',
                        isLoading: vehicleState.isLoading,
                        onPressed: form.valid && !vehicleState.isLoading
                            ? () async {
                                final plate =
                                    form.control('plate_number').value
                                        as String;
                                final type =
                                    form.control('type').value as String;

                                try {
                                  await ref
                                      .read(vehicleProvider.notifier)
                                      .addVehicle(plate, type);
                                  if (!context.mounted) return;
                                  context.pop();
                                } catch (_) {
                                  // Error handled by watching state
                                }
                              }
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
