import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextAppButtonTheme {
  // private
  TextAppButtonTheme._();

  static final lightTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
    elevation: 1,
    backgroundColor: ColorsTheme.tertiary,
    disabledBackgroundColor: ColorsTheme.ligtGrey,
    disabledForegroundColor: ColorsTheme.grey,
    foregroundColor: ColorsTheme.tertiaryDarker,
    iconColor: ColorsTheme.tertiaryDarker,
    textStyle: const TextStyle(
      fontSize: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ));

  static final darkTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
    elevation: 1,
    backgroundColor: ColorsTheme.tertiaryDarker,
    foregroundColor: ColorsTheme.tertiary,
    disabledBackgroundColor: ColorsTheme.tertiaryDark,
    disabledForegroundColor: ColorsTheme.tertiaryLightDark,
    textStyle: const TextStyle(
      fontSize: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    iconColor: ColorsTheme.tertiary,
  ));
}
