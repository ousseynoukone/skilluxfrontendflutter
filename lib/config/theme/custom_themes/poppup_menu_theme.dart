import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class PopupAppMenuTheme {
  // Private constructor to prevent instantiation
  PopupAppMenuTheme._();

  static PopupMenuThemeData lightPopupMenuTheme = PopupMenuThemeData(
    color: ColorsTheme.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 8.0,
    shadowColor: ColorsTheme.grey,
    surfaceTintColor: ColorsTheme.white,
    textStyle: const TextStyle(color: ColorsTheme.black),
    enableFeedback: true,
    iconColor: ColorsTheme.tertiaryDarker,
    iconSize: 24.0,
  );

  static PopupMenuThemeData darkPopupMenuTheme = PopupMenuThemeData(
    color: ColorsTheme.tertiaryMidDarker,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 8.0,
    shadowColor: ColorsTheme.tertiaryDark,
    surfaceTintColor: ColorsTheme.black,
    textStyle: const TextStyle(color: ColorsTheme.white),
    enableFeedback: true,
    iconColor: ColorsTheme.tertiary,
    iconSize: 24.0,
  );
}
