import 'package:flutter/material.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/presentation/widgets/forms/custom_reactive_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LabeledReactiveTextField<T> extends StatelessWidget {
  final String label;
  final String formControlName;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Map<String, String Function(Object)>? validationMessages;
  final void Function(FormControl<T>)? onSubmitted;
  final bool? filled;
  final Color? fillColor;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final ReactiveFormFieldCallback<T>? onChanged;

  final bool isRequired;

  const LabeledReactiveTextField({
    super.key,
    required this.label,
    required this.formControlName,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.validationMessages,
    this.onSubmitted,
    this.filled,
    this.fillColor,
    this.textCapitalization = TextCapitalization.none,
    this.isRequired = false,
    this.autofocus = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.black87,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomReactiveTextField<T>(
          formControlName: formControlName,
          hintText: hintText,
          prefixIcon: prefixIcon,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          validationMessages: validationMessages,
          onSubmitted: onSubmitted,
          filled: filled,
          fillColor: fillColor,
          textCapitalization: textCapitalization,
          autofocus: autofocus,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
