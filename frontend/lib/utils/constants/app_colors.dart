import 'package:flutter/material.dart';

abstract final class AppColors {
  // Neutrals
  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color primary = Color(0xFF333233);

  // Surfaces & Containers
  static final Color inputFill = Colors.grey.shade50;
  static final Color inputBorder = Colors.grey.shade300;
  static final Color surfaceVariant = Colors.grey.shade200;
  static final Color outlineVariant = Colors.grey.shade300;

  /// Secondary / hint text colour.
  static final Color textSecondary = Colors.grey.shade600;
  static const Color error = Colors.red;

  /// Disabled button background.
  static final Color buttonDisabled = Colors.grey.shade300;

  // Occupied (red)
  static final Color occupiedBackground = Colors.red.shade50;
  static final Color occupiedBorder = Colors.red.shade300;
  static final Color occupiedText = Colors.red.shade700;
  static final Color occupiedTextDark = Colors.red.shade900;
  static const Color redAccent = Colors.redAccent;
  static const Color orangeAccent = Colors.orangeAccent;

  // Available (green)
  static final Color availableBackground = Colors.green.shade50;
  static final Color availableBorder = Colors.green.shade300;
  static final Color availableText = Colors.green.shade700;
  static final Color availableTextDark = Colors.green.shade900;

  // Entrance (indigo)
  static final Color entranceBackground = Colors.indigo.shade50;
  static final Color entranceBorder = Colors.indigo.shade300;
  static final Color entranceText = Colors.indigo.shade700;
  static final Color entranceTextDark = Colors.indigo.shade900;
}
