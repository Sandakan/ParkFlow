import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/gen/assets.gen.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/widgets/forms/custom_reactive_text_field.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

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
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(authProvider.notifier).clearError();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12.0),

                          // Logo — left aligned
                          Assets.images.logoWhite.image(height: 48.0),

                          const SizedBox(height: 32.0),

                          // Title
                          Text(
                            context.l10n.createAccountTitle,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 8.0),

                          // Subtitle
                          Text(
                            context.l10n.signUpSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withValues(alpha: 0.7),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 32.0),

                          // Name label
                          Text(
                            context.l10n.fullNameLabel,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Name field
                          CustomReactiveTextField<String>(
                            formControlName: 'name',
                            hintText: context.l10n.fullNameHint,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.nameRequired,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Email label
                          Text(
                            'Email',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Email field
                          CustomReactiveTextField<String>(
                            formControlName: 'email',
                            hintText: 'you@example.com',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.emailRequired,
                              ValidationMessage.email: (error) =>
                                  context.l10n.emailInvalid,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Password label
                          Text(
                            'Password',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Password field
                          CustomReactiveTextField<String>(
                            formControlName: 'password',
                            hintText: '••••••••',
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.passwordRequired,
                              ValidationMessage.minLength: (error) =>
                                  context.l10n.passwordMinLength,
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Confirm Password label
                          Text(
                            context.l10n.confirmPasswordLabel,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Confirm Password field
                          CustomReactiveTextField<String>(
                            formControlName: 'passwordConfirmation',
                            hintText: '••••••••',
                            obscureText: true,
                            onSubmitted: (_) => _submit(),
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.confirmPasswordRequired,
                              ValidationMessage.mustMatch: (error) =>
                                  context.l10n.passwordsMustMatch,
                            },
                          ),

                          // Error message
                          if (authState.error != null) ...[
                            const SizedBox(height: 24.0),
                            Container(
                              padding: const EdgeInsets.symmetric(
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

                          const SizedBox(height: 32.0),

                          // Register button — full width
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              final enabled =
                                  form.valid && !authState.isLoading;
                              return SizedBox(
                                width: double.infinity,
                                height: 54.0,
                                child: ElevatedButton(
                                  onPressed: enabled ? _submit : null,
                                  child: authState.isLoading
                                      ? const SizedBox(
                                          width: 22.0,
                                          height: 22.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : Text(context.l10n.signUpButton),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24.0),

                          // Already have an account? Sign in
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.l10n.alreadyHaveAccount,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.6),
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

                          const SizedBox(height: 32.0),
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

  void _submit() {
    if (form.valid) {
      ref
          .read(authProvider.notifier)
          .register(
            form.control('name').value,
            form.control('email').value,
            form.control('password').value,
          );
    } else {
      form.markAllAsTouched();
    }
  }
}
