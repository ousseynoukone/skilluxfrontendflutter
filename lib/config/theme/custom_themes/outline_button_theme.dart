import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class OutlineButtonAppTheme {
  // private
  OutlineButtonAppTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 1,
      foregroundColor: ColorsTheme.black,
      side: const BorderSide(color: ColorsTheme.tertiaryDark),
      textStyle: const TextStyle(
        fontSize: 12,
        color: ColorsTheme.black,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 1,
      foregroundColor: ColorsTheme.white,
      side: const BorderSide(color: ColorsTheme.tertiary),
      textStyle: const TextStyle(
        fontSize: 12,
        color: ColorsTheme.white,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
