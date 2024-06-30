import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class AppColorScheme {
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: ColorsTheme.white,
    onPrimary: ColorsTheme.tertiary,
    secondary: ColorsTheme.tertiaryLightDark,
    onSecondary: ColorsTheme.tertiaryDarker,
    error: ColorsTheme.error,
    onError: Colors.white,
    surface: ColorsTheme.tertiary,
    onSurface: Colors.black,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: ColorsTheme.tertiaryDarker,
    onPrimary: ColorsTheme.tertiaryDark,
    secondary: ColorsTheme.tertiaryMidDarker,
    onSecondary: ColorsTheme.tertiaryLightDark,
    error: ColorsTheme.error,
    onError: Colors.white,
    surface: ColorsTheme.tertiaryLightDark,
    onSurface: Colors.white,
  );
}
