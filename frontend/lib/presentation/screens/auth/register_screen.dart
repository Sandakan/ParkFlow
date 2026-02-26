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
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
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
                      SizedBox(height: 12.h),

                      // Logo — left aligned
                      Assets.images.logoWhite.image(height: 48.h),

                      SizedBox(height: 32.h),

                      // Title
                      Text(
                        'Create Account',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle
                      Text(
                        'Sign up to get started!',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Name label
                      Text(
                        'Full Name',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Name field
                      CustomReactiveTextField<String>(
                        formControlName: 'name',
                        hintText: 'John Doe',
                        keyboardType: TextInputType.name,
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
                              'Name is required',
                        },
                      ),

                      SizedBox(height: 24.h),

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
                      CustomReactiveTextField<String>(
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
                      CustomReactiveTextField<String>(
                        formControlName: 'password',
                        hintText: '••••••••',
                        obscureText: true,
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
                              context.l10n.passwordRequired,
                          ValidationMessage.minLength: (error) =>
                              context.l10n.passwordMinLength,
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Confirm Password label
                      Text(
                        'Confirm Password',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Confirm Password field
                      CustomReactiveTextField<String>(
                        formControlName: 'passwordConfirmation',
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
                              'Confirm Password is required',
                          ValidationMessage.mustMatch: (error) =>
                              'Passwords must match',
                        },
                      ),

                      // Error message
                      if (authState.error != null) ...[
                        SizedBox(height: 24.h),
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

                      // Register button — full width
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
                                      'Sign Up',
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

                      SizedBox(height: 24.h),

                      // Already have an account? Sign in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
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
