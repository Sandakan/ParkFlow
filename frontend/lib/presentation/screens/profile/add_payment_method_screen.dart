import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_dropdown_field.dart';
import 'package:parkflow/presentation/notifiers/profile/payment_notifier.dart';
import 'package:parkflow/presentation/widgets/common/app_buttons.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';

class AddPaymentMethodScreen extends ConsumerWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final paymentState = ref.watch(paymentProvider);

    final errorMessage = paymentState.error != null
        ? AppException.getLocalizedErrorMessage(
            paymentState.error!,
            AppLocalizations.of(context),
          )
        : null;

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
                    ],
                  ),
                  const SizedBox(height: 24),
                  LabeledReactiveTextField<String>(
                    label: 'Provider Name',
                    formControlName: 'provider',
                    hintText: 'e.g. Visa, MasterCard, Bank',
                    prefixIcon: Icons.business_outlined,
                    isRequired: true,
                    onChanged: (_) {
                      if (paymentState.error != null) {
                        ref.read(paymentProvider.notifier).clearError();
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  LabeledReactiveTextField<String>(
                    label: 'Last 4 Digits',
                    formControlName: 'last4',
                    hintText: 'e.g. 1234',
                    prefixIcon: Icons.credit_card_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      if (paymentState.error != null) {
                        ref.read(paymentProvider.notifier).clearError();
                      }
                    },
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
                        label: 'Add Payment Method',
                        isLoading: paymentState.isLoading,
                        onPressed: form.valid && !paymentState.isLoading
                            ? () async {
                                final router = GoRouter.of(context);

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

                                  router.pop();
                                } catch (_) {}
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
