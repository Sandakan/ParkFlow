import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/l10n/app_localizations.dart';
import 'package:parkflow/presentation/notifiers/auth/auth_notifier.dart';
import 'package:parkflow/presentation/widgets/forms/custom_reactive_text_field.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

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

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400.w),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.h,
                children: [
                  Column(
                    spacing: 8.h,
                    children: [
                      Text(
                        context.l10n.loginTitle,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        context.l10n.signInToContinue,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  CustomReactiveTextField<String>(
                    formControlName: 'email',
                    labelText: context.l10n.emailLabel,
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          context.l10n.emailRequired,
                      ValidationMessage.email: (error) =>
                          context.l10n.emailInvalid,
                    },
                  ),
                  CustomReactiveTextField<String>(
                    formControlName: 'password',
                    labelText: context.l10n.passwordLabel,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    onSubmitted: (_) => _submit(),
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          context.l10n.passwordRequired,
                      ValidationMessage.minLength: (error) =>
                          context.l10n.passwordMinLength,
                    },
                  ),
                  if (authState.error != null)
                    Text(
                      AppException.getLocalizedErrorMessage(
                        authState.error,
                        AppLocalizations.of(context),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed: form.valid && !authState.isLoading
                            ? _submit
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: authState.isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(context.l10n.loginButton),
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

  void _submit() {
    if (form.valid) {
      ref
          .read(authProvider.notifier)
          .login(form.control('email').value, form.control('password').value);
    } else {
      form.markAllAsTouched();
    }
  }
}
