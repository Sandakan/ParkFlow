import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/gen/assets.gen.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/widgets/forms/custom_reactive_text_field.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/routes/router_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
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
                          const SizedBox(height: 32.0),

                          // Logo — left aligned
                          Assets.images.logoWhite.image(height: 48.0),

                          const SizedBox(height: 40.0),

                          // Title
                          Text(
                            context.l10n.loginTitle,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 8.0),

                          // Subtitle
                          Text(
                            context.l10n.welcomeBackSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withValues(alpha: 0.7),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 40.0),

                          // Email label
                          Text(
                            context.l10n.emailLabel,
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
                            context.l10n.passwordLabel,
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
                            onSubmitted: (_) => _submit(),
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  context.l10n.passwordRequired,
                              ValidationMessage.minLength: (error) =>
                                  context.l10n.passwordMinLength,
                            },
                          ),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                context.l10n.forgotPassword,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),

                          // Error message
                          if (authState.error != null) ...[
                            const SizedBox(height: 12.0),
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

                          // Login button — full width
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
                                      : Text(context.l10n.signInButton),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32.0),

                          // Don't have an account? Sign up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.l10n.dontHaveAccount,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.6),
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref.read(authProvider.notifier).clearError();
                                  const RegisterRoute().push(context);
                                },
                                child: Text(
                                  context.l10n.signUp,
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
      final email = form.control('email').value;
      final password = form.control('password').value;

      ref.read(authProvider.notifier).login(email, password);
    } else {
      form.markAllAsTouched();
    }
  }
}
