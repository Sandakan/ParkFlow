import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';
import 'package:parkflow/presentation/notifiers/profile/vehicle_notifier.dart';

class AddVehicleScreen extends ConsumerWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = FormGroup({
      'plate_number': FormControl<String>(validators: [Validators.required]),
      'type': FormControl<String>(
        value: 'car',
        validators: [Validators.required],
      ),
    });

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
                  const SizedBox(height: 48),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed: form.valid
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
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to add vehicle: $e',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Text(
                          'Add Vehicle',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
