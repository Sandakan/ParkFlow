import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControlName: formControlName,
      validationMessages: validationMessages,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: filled,
        fillColor: fillColor,
        contentPadding: contentPadding,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
    );
  }
}
