import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class AppColorScheme {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: ColorsTheme.tertiary,
    onPrimary: ColorsTheme.tertiaryDarker,
    primaryFixed: ColorsTheme.grey,
    primaryContainer: ColorsTheme.ligtGrey,
    onPrimaryContainer: ColorsTheme.tertiaryMidDarker,
    secondary: ColorsTheme.tertiaryLightDark,
    onSecondary: ColorsTheme.tertiaryDark,
    error: ColorsTheme.error,
    onError: Colors.white,
    surface: ColorsTheme.tertiary,
    onSurface: Colors.black,
    tertiary: ColorsTheme.white,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: ColorsTheme.tertiaryDarker,
    onPrimary: ColorsTheme.tertiary,
    primaryFixed: ColorsTheme.tertiaryLightDark,
    primaryContainer: ColorsTheme.tertiaryMidDarker,
    onPrimaryContainer: ColorsTheme.tertiaryLightDark,
    secondary: ColorsTheme.tertiaryMidDarker,
    onSecondary: ColorsTheme.tertiaryLightDark,
    error: ColorsTheme.error,
    onError: Colors.white,
    surface: ColorsTheme.tertiaryMidDarker,
    onSurface: Colors.white,
    tertiary: ColorsTheme.black,
  );
}
