import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class AppColorScheme {
  static ColorScheme lightColorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: ColorsTheme.ligtGrey,
      onPrimary: ColorsTheme.tertiary,
      secondary: ColorsTheme.tertiaryLightDark,
      onSecondary: ColorsTheme.tertiaryDark,
      error: ColorsTheme.error,
      onError: Colors.white,
      surface: ColorsTheme.tertiary,
      onSurface: Colors.black,
      onTertiary: ColorsTheme.white);

  static ColorScheme darkColorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: ColorsTheme.tertiaryDarker,
      onPrimary: ColorsTheme.tertiaryDark,
      secondary: ColorsTheme.tertiaryMidDarker,
      onSecondary: ColorsTheme.tertiary,
      error: ColorsTheme.error,
      onError: Colors.white,
      surface: ColorsTheme.tertiaryLightDark,
      onSurface: Colors.white,
      onTertiary: ColorsTheme.black);
}
