import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';
import 'package:parkflow/presentation/notifiers/profile/payment_notifier.dart';

class AddPaymentMethodScreen extends ConsumerWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = FormGroup({
      'provider': FormControl<String>(validators: [Validators.required]),
      'type': FormControl<String>(
        value: 'card',
        validators: [Validators.required],
      ),
      'last4': FormControl<String>(validators: [Validators.maxLength(4)]),
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Add Payment Method',
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
                  LabeledReactiveDropdownField<String>(
                    label: 'Payment Type',
                    formControlName: 'type',
                    prefixIcon: Icons.category_outlined,
                    isRequired: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'card',
                        child: Text('Credit/Debit Card'),
                      ),
                      DropdownMenuItem(value: 'cash', child: Text('Cash')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  LabeledReactiveTextField<String>(
                    label: 'Provider Name',
                    formControlName: 'provider',
                    hintText: 'e.g. Visa, MasterCard, Personal',
                    prefixIcon: Icons.business_outlined,
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  LabeledReactiveTextField<String>(
                    label: 'Last 4 Digits',
                    formControlName: 'last4',
                    hintText: 'e.g. 1234',
                    prefixIcon: Icons.credit_card_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 48),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed: form.valid
                            ? () async {
                                final provider =
                                    form.control('provider').value as String;
                                final type =
                                    form.control('type').value as String;
                                final last4 =
                                    form.control('last4').value as String?;
                                try {
                                  await ref
                                      .read(paymentProvider.notifier)
                                      .addPaymentMethod(
                                        provider,
                                        type,
                                        last4: last4,
                                      );
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to add payment method: $e',
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
                          'Add Payment Method',
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
