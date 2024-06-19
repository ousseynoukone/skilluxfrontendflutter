import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class ElevatedButtonAppTheme {
  // private
  ElevatedButtonAppTheme._();

  static final ElevatedButtonThemeData elevatedButtonThemeDataLight =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: ColorsTheme.white,
              backgroundColor: ColorsTheme.primary,
              disabledBackgroundColor: ColorsTheme.tertiary,
              disabledForegroundColor: ColorsTheme.tertiary,
              side: const BorderSide(color: ColorsTheme.primary),
              padding: const EdgeInsets.all(8),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorsTheme.white,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))));

  static final ElevatedButtonThemeData elevatedButtonThemeDataDark =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: ColorsTheme.white,
              backgroundColor: ColorsTheme.primary,
              disabledBackgroundColor: ColorsTheme.tertiary,
              disabledForegroundColor: ColorsTheme.tertiary,
              side: const BorderSide(color: ColorsTheme.primary),
              padding: const EdgeInsets.all(8),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorsTheme.white,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))));
}