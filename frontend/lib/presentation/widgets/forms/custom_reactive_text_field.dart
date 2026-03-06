import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:parkflow/utils/constants/app_colors.dart';

class CustomReactiveTextField<T> extends StatelessWidget {
  final String formControlName;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(FormControl<T>)? onSubmitted;
  final Map<String, String Function(Object)>? validationMessages;
  final bool? filled;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final bool autofocus;

  const CustomReactiveTextField({
    super.key,
    required this.formControlName,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.validationMessages,
    this.filled,
    this.fillColor,
    this.border,
    this.focusedBorder,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorder =
        border ??
        OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(12.0),
        );

    final defaultFocusedBorder =
        focusedBorder ??
        OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        );

    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.error, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );

    final focusedErrorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      borderRadius: BorderRadius.circular(12.0),
    );

    return ReactiveTextField<T>(
      formControlName: formControlName,
      validationMessages: validationMessages,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textSecondary),
        filled: filled ?? true,
        fillColor: fillColor ?? AppColors.inputFill,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: defaultFocusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.textSecondary)
            : null,
      ),
    );
  }
}
