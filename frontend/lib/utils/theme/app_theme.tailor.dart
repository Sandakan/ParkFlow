// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ParkingThemeTailorMixin on ThemeExtension<ParkingTheme> {
  Color get occupiedBackground;
  Color get occupiedBorder;
  Color get occupiedText;
  Color get occupiedTextDark;
  Color get availableBackground;
  Color get availableBorder;
  Color get availableText;
  Color get availableTextDark;

  @override
  ParkingTheme copyWith({
    Color? occupiedBackground,
    Color? occupiedBorder,
    Color? occupiedText,
    Color? occupiedTextDark,
    Color? availableBackground,
    Color? availableBorder,
    Color? availableText,
    Color? availableTextDark,
  }) {
    return ParkingTheme(
      occupiedBackground: occupiedBackground ?? this.occupiedBackground,
      occupiedBorder: occupiedBorder ?? this.occupiedBorder,
      occupiedText: occupiedText ?? this.occupiedText,
      occupiedTextDark: occupiedTextDark ?? this.occupiedTextDark,
      availableBackground: availableBackground ?? this.availableBackground,
      availableBorder: availableBorder ?? this.availableBorder,
      availableText: availableText ?? this.availableText,
      availableTextDark: availableTextDark ?? this.availableTextDark,
    );
  }

  @override
  ParkingTheme lerp(covariant ThemeExtension<ParkingTheme>? other, double t) {
    if (other is! ParkingTheme) return this as ParkingTheme;
    return ParkingTheme(
      occupiedBackground: Color.lerp(
        occupiedBackground,
        other.occupiedBackground,
        t,
      )!,
      occupiedBorder: Color.lerp(occupiedBorder, other.occupiedBorder, t)!,
      occupiedText: Color.lerp(occupiedText, other.occupiedText, t)!,
      occupiedTextDark: Color.lerp(
        occupiedTextDark,
        other.occupiedTextDark,
        t,
      )!,
      availableBackground: Color.lerp(
        availableBackground,
        other.availableBackground,
        t,
      )!,
      availableBorder: Color.lerp(availableBorder, other.availableBorder, t)!,
      availableText: Color.lerp(availableText, other.availableText, t)!,
      availableTextDark: Color.lerp(
        availableTextDark,
        other.availableTextDark,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParkingTheme &&
            const DeepCollectionEquality().equals(
              occupiedBackground,
              other.occupiedBackground,
            ) &&
            const DeepCollectionEquality().equals(
              occupiedBorder,
              other.occupiedBorder,
            ) &&
            const DeepCollectionEquality().equals(
              occupiedText,
              other.occupiedText,
            ) &&
            const DeepCollectionEquality().equals(
              occupiedTextDark,
              other.occupiedTextDark,
            ) &&
            const DeepCollectionEquality().equals(
              availableBackground,
              other.availableBackground,
            ) &&
            const DeepCollectionEquality().equals(
              availableBorder,
              other.availableBorder,
            ) &&
            const DeepCollectionEquality().equals(
              availableText,
              other.availableText,
            ) &&
            const DeepCollectionEquality().equals(
              availableTextDark,
              other.availableTextDark,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(occupiedBackground),
      const DeepCollectionEquality().hash(occupiedBorder),
      const DeepCollectionEquality().hash(occupiedText),
      const DeepCollectionEquality().hash(occupiedTextDark),
      const DeepCollectionEquality().hash(availableBackground),
      const DeepCollectionEquality().hash(availableBorder),
      const DeepCollectionEquality().hash(availableText),
      const DeepCollectionEquality().hash(availableTextDark),
    );
  }
}
