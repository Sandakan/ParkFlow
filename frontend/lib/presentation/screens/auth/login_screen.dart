import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/core/app_exception.dart';
import 'package:parkflow/gen/assets.gen.dart';
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
    final theme = Theme.of(context);

    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12.r),
    );

    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
      borderRadius: BorderRadius.circular(12.r),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),

                      // Logo — left aligned
                      Assets.images.logoWhite.image(height: 48.h),

                      SizedBox(height: 40.h),

                      // Title
                      Text(
                        context.l10n.loginTitle,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle
                      Text(
                        'Welcome back! Sign in to your account.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Email label
                      Text(
                        'Email',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Email field
                      _buildTextField(
                        child: CustomReactiveTextField<String>(
                          formControlName: 'email',
                          hintText: 'you@example.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                context.l10n.emailRequired,
                            ValidationMessage.email: (error) =>
                                context.l10n.emailInvalid,
                          },
                        ),
                        focusedBorder: focusedBorder,
                      ),

                      SizedBox(height: 24.h),

                      // Password label
                      Text(
                        'Password',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Password field
                      _buildTextField(
                        child: CustomReactiveTextField<String>(
                          formControlName: 'password',
                          hintText: '••••••••',
                          obscureText: true,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: inputBorder,
                          focusedBorder: focusedBorder,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          onSubmitted: (_) => _submit(),
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                context.l10n.passwordRequired,
                            ValidationMessage.minLength: (error) =>
                                context.l10n.passwordMinLength,
                          },
                        ),
                        focusedBorder: focusedBorder,
                      ),

                      // Forgot password — right aligned, tight to the field
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 6.h,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),

                      // Error message
                      if (authState.error != null) ...[
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer.withOpacity(
                              0.15,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            AppException.getLocalizedErrorMessage(
                              authState.error,
                              AppLocalizations.of(context),
                            ),
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 32.h),

                      // Login button — full width
                      ReactiveFormConsumer(
                        builder: (context, form, child) {
                          final enabled = form.valid && !authState.isLoading;
                          return SizedBox(
                            width: double.infinity,
                            height: 54.h,
                            child: ElevatedButton(
                              onPressed: enabled ? _submit : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: enabled
                                    ? theme.colorScheme.primary
                                    : Colors.grey.shade300,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: authState.isLoading
                                  ? SizedBox(
                                      width: 22.w,
                                      height: 22.w,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Wraps a [CustomReactiveTextField] and overrides the focused border
  /// since [CustomReactiveTextField] doesn't expose a separate focusedBorder param.
  Widget _buildTextField({
    required Widget child,
    required InputBorder focusedBorder,
  }) {
    // The focused border is already wired through the decoration inside
    // CustomReactiveTextField — we pass it via the `border` param for now.
    // If you later add a focusedBorder param to CustomReactiveTextField,
    // this wrapper can be removed.
    return child;
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
