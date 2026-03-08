import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/utils/helpers/talker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/gen/assets.gen.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/routes/router_provider.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'otp': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6),
          Validators.number(),
        ],
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
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackButton(color: AppColors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ReactiveForm(
              formGroup: form,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.images.logoWhite.image(height: 48.0),
                    const SizedBox(height: 40.0),
                    Text(
                      context.l10n.verifyOtpTitle,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      context.l10n.verifyOtpSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    LabeledReactiveTextField<String>(
                      label: "Verification Code",
                      formControlName: 'otp',
                      hintText: "123456",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      isRequired: true,
                      onSubmitted: (_) => _submit(ref, form),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            context.l10n.otpRequired,
                        ValidationMessage.minLength: (error) =>
                            context.l10n.otpInvalid,
                        ValidationMessage.maxLength: (error) =>
                            context.l10n.otpInvalid,
                        ValidationMessage.number: (error) =>
                            context.l10n.otpInvalid,
                      },
                    ),
                    if (authState.error != null) ...[
                      const SizedBox(height: 12.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          AppException.getLocalizedErrorMessage(
                            authState.error,
                            AppLocalizations.of(context),
                          ),
                          style: TextStyle(
                            color: theme.colorScheme.error,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32.0),
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        final enabled = form.valid && !authState.isLoading;

                        return SizedBox(
                          width: double.infinity,
                          height: 54.0,
                          child: ElevatedButton(
                            onPressed: enabled
                                ? () => _submit(ref, form)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: enabled
                                  ? theme.colorScheme.primary
                                  : AppColors.buttonDisabled,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                            child: authState.isLoading
                                ? const SizedBox(
                                    width: 22.0,
                                    height: 22.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.white,
                                    ),
                                  )
                                : Text(
                                    context.l10n.verifyOtpButton,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
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
      ),
    );
  }

  void _submit(WidgetRef ref, FormGroup form) async {
    if (form.valid) {
      final otp = form.control('otp').value as String;
      try {
        await ref.read(authProvider.notifier).verifyOtp(widget.email, otp);
        if (mounted) {
          ResetPasswordRoute(email: widget.email, otp: otp).push(context);
        }
      } catch (e) {
        talker.error(e);
      }
    } else {
      form.markAllAsTouched();
    }
  }
}
