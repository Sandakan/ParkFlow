import 'package:flutter/material.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LabeledReactiveDropdownField<T> extends StatelessWidget {
  final String label;
  final String formControlName;
  final String? hintText;
  final IconData? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final bool? filled;
  final Color? fillColor;

  final bool isRequired;

  const LabeledReactiveDropdownField({
    super.key,
    required this.label,
    required this.formControlName,
    required this.items,
    this.hintText,
    this.prefixIcon,
    this.filled,
    this.fillColor,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.inputBorder),
      borderRadius: BorderRadius.circular(12.0),
    );

    final defaultFocusedBorder = OutlineInputBorder(
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
              fontFamily: 'Outfit',
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
        ReactiveDropdownField<T>(
          formControlName: formControlName,
          items: items,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            filled: filled ?? true,
            fillColor: fillColor ?? AppColors.inputFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            border: defaultBorder,
            enabledBorder: defaultBorder,
            focusedBorder: defaultFocusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.textSecondary)
                : null,
          ),
        ),
      ],
    );
  }
}
