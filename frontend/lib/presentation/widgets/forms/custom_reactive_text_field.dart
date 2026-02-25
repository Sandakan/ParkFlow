import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveTextField<T> extends StatelessWidget {
  final String formControlName;
  final String labelText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(FormControl<T>)? onSubmitted;
  final Map<String, String Function(Object)>? validationMessages;

  const CustomReactiveTextField({
    super.key,
    required this.formControlName,
    required this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.validationMessages,
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
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
    );
  }
}
