import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class FloatingAppActionButtonTheme {
  // Private constructor to prevent instantiation
  FloatingAppActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButton =
      FloatingActionButtonThemeData(
    backgroundColor: ColorsTheme.white,
    elevation: 8.0,
    splashColor: ColorsTheme.tertiaryLightDark,
    foregroundColor: ColorsTheme.tertiaryDarker,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );

  static FloatingActionButtonThemeData darkFloatingActionButton =
      FloatingActionButtonThemeData(
    backgroundColor: ColorsTheme.tertiaryMidDarker,
    elevation: 8.0,
    splashColor: ColorsTheme.tertiaryDark,
    foregroundColor: ColorsTheme.tertiary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
}
