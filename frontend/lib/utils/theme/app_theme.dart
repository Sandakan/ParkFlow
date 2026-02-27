import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.none)
class ParkingTheme extends ThemeExtension<ParkingTheme>
    with _$ParkingThemeTailorMixin {
  const ParkingTheme({
    required this.occupiedBackground,
    required this.occupiedBorder,
    required this.occupiedText,
    required this.occupiedTextDark,
    required this.availableBackground,
    required this.availableBorder,
    required this.availableText,
    required this.availableTextDark,
  });

  @override
  final Color occupiedBackground;
  @override
  final Color occupiedBorder;
  @override
  final Color occupiedText;
  @override
  final Color occupiedTextDark;
  @override
  final Color availableBackground;
  @override
  final Color availableBorder;
  @override
  final Color availableText;
  @override
  final Color availableTextDark;

  static final light = ParkingTheme(
    occupiedBackground: AppColors.occupiedBackground,
    occupiedBorder: AppColors.occupiedBorder,
    occupiedText: AppColors.occupiedText,
    occupiedTextDark: AppColors.occupiedTextDark,
    availableBackground: AppColors.availableBackground,
    availableBorder: AppColors.availableBorder,
    availableText: AppColors.availableText,
    availableTextDark: AppColors.availableTextDark,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF333233),
        primary: const Color(0xFF333233),
        surface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
      extensions: [ParkingTheme.light],
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      primaryTextTheme: GoogleFonts.poppinsTextTheme(
        baseTheme.primaryTextTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: baseTheme.colorScheme.primary,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

extension BuildContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeExtras on ThemeData {
  ParkingTheme get parkingColors => extension<ParkingTheme>()!;
}
