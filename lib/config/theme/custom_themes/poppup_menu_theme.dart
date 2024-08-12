import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class PopupAppMenuTheme {
  // Private constructor to prevent instantiation
  PopupAppMenuTheme._();

  static PopupMenuThemeData lightPopupMenuTheme = PopupMenuThemeData(
    color: ColorsTheme.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 4,
    shadowColor: ColorsTheme.grey,
    surfaceTintColor: ColorsTheme.white,
    textStyle: const TextStyle(color: ColorsTheme.black),
    enableFeedback: false,
    iconColor: ColorsTheme.tertiaryDarker,
    iconSize: 24.0,
  );

  static PopupMenuThemeData darkPopupMenuTheme = PopupMenuThemeData(
    color: ColorsTheme.tertiaryMidDarker,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 4,
    shadowColor: ColorsTheme.tertiaryDarker,
    surfaceTintColor: ColorsTheme.black,
    textStyle: const TextStyle(color: ColorsTheme.white),
    enableFeedback: false,
    iconColor: ColorsTheme.tertiary,
    iconSize: 24.0,
  );
}
