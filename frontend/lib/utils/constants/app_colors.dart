import 'package:flutter/material.dart';

abstract final class AppColors {
  // Neutrals
  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;

  static final Color inputFill = Colors.grey.shade50;
  static final Color inputBorder = Colors.grey.shade300;

  /// Secondary / hint text colour.
  static final Color textSecondary = Colors.grey.shade600;

  /// Disabled button background.
  static final Color buttonDisabled = Colors.grey.shade300;

  // Occupied (red)
  static final Color occupiedBackground = Colors.red.shade50;
  static final Color occupiedBorder = Colors.red.shade300;
  static final Color occupiedText = Colors.red.shade700;
  static final Color occupiedTextDark = Colors.red.shade900;

  // Available (green)
  static final Color availableBackground = Colors.green.shade50;
  static final Color availableBorder = Colors.green.shade300;
  static final Color availableText = Colors.green.shade700;
  static final Color availableTextDark = Colors.green.shade900;
}
