import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextAppTheme {
  // private
  TextAppTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: ColorsTheme.black,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.black,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.black,
    ),
    titleLarge: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: ColorsTheme.black,
    ),
    titleMedium: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.black,
    ),
    bodyLarge: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.black,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.black,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.black.withOpacity(0.6),
    ),
    labelLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.black,
    ),
    labelMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.black,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.black.withOpacity(0.6),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: ColorsTheme.white,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.white,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.white,
    ),
    titleLarge: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: ColorsTheme.white,
    ),
    titleMedium: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: ColorsTheme.white,
    ),
    titleSmall: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.white,
    ),
    bodyLarge: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.white,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.white,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.white.withOpacity(0.6),
    ),
    labelLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: ColorsTheme.white,
    ),
    labelMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.white,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: ColorsTheme.white.withOpacity(0.6),
    ),
  );
}
