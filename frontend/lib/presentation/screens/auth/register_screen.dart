import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/gen/assets.gen.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/widgets/forms/labeled_reactive_text_field.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/language_picker_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup(
      {
        'name': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)],
        ),
        'passwordConfirmation': FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [
        const MustMatchValidator('password', 'passwordConfirmation', true),
      ],
    );
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
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black87),
          onPressed: () {
            ref.read(authProvider.notifier).clearError();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Assets.images.logoWhite.image(height: 48.0),
                              const LanguagePickerButton(),
                            ],
                          ),

                          SizedBox(height: 32.0),

                          // Title
                          Text(
                            context.l10n.createAccountTitle,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),

                          SizedBox(height: 8.0),

                          // Subtitle
                          Text(
                            context.l10n.signUpSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 32.0),

                          // Name field
                          LabeledReactiveTextField<String>(
                            label: context.l10n.fullNameLabel,
                            formControlName: 'name',
                            hintText: context.l10n.fullNameHint,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            isRequired: true,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.nameRequired,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Email field
                          LabeledReactiveTextField<String>(
                            label: context.l10n.emailLabel,
                            formControlName: 'email',
                            hintText: context.l10n.emailHint,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            isRequired: true,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.emailRequired,
                              ValidationMessage.email: (error) =>
                                  context.l10n.emailInvalid,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Password field
                          LabeledReactiveTextField<String>(
                            label: context.l10n.passwordLabel,
                            formControlName: 'password',
                            hintText: context.l10n.passwordHint,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            isRequired: true,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.passwordRequired,
                              ValidationMessage.minLength: (error) =>
                                  context.l10n.passwordMinLength,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Confirm Password field
                          LabeledReactiveTextField<String>(
                            label: context.l10n.confirmPasswordLabel,
                            formControlName: 'passwordConfirmation',
                            hintText: context.l10n.passwordHint,
                            obscureText: true,
                            isRequired: true,
                            onSubmitted: (_) => _submit(ref, form),
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.confirmPasswordRequired,
                              ValidationMessage.mustMatch: (error) =>
                                  context.l10n.passwordsMustMatch,
                            },
                          ),

                          // Error message
                          if (authState.error != null) ...[
                            SizedBox(height: 24.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.errorContainer
                                    .withValues(alpha: 0.15),
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

                          SizedBox(height: 32.0),

                          // Register button — full width
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              final enabled =
                                  form.valid && !authState.isLoading;
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
                                      ? SizedBox(
                                          width: 22.0,
                                          height: 22.0,
                                          child:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.white,
                                              ),
                                        )
                                      : Text(
                                          context.l10n.signUpButton,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 24.0),

                          // Already have an account? Sign in
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.l10n.alreadyHaveAccount,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref.read(authProvider.notifier).clearError();
                                  context.pop();
                                },
                                child: Text(
                                  context.l10n.signIn,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 32.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(WidgetRef ref, FormGroup form) {
    if (form.valid) {
      ref
          .read(authProvider.notifier)
          .register(
            form.control('name').value as String,
            form.control('email').value as String,
            form.control('password').value as String,
          );
    } else {
      form.markAllAsTouched();
    }
  }
}
