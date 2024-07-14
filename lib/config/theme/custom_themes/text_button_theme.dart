import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextAppButtonTheme {
  // private
  TextAppButtonTheme._();

  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 1,
      backgroundColor: ColorsTheme.tertiary,
      iconColor: ColorsTheme.secondary,
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ).copyWith(
      foregroundColor: WidgetStateProperty.all(ColorsTheme.tertiaryDarker),
    ),
  );

  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 1,
      backgroundColor: ColorsTheme.tertiaryDarker,
      textStyle: const TextStyle(
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      iconColor: ColorsTheme.secondary,
    ).copyWith(
      foregroundColor: WidgetStateProperty.all(ColorsTheme.tertiary),
    ),
  );
}
