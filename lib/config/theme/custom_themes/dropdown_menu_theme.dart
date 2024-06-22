import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class DropdownMenuAppTheme {
  // Private constructor to prevent instantiation
  DropdownMenuAppTheme._();

  static DropdownMenuThemeData lightDropdownMenuThemeData =
      DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(ColorsTheme.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsTheme.grey, width: 1),
        ),
      ),
      elevation: WidgetStateProperty.all(8.0),
      shadowColor: WidgetStateProperty.all(ColorsTheme.grey),
    ),
  );

  static DropdownMenuThemeData darkDropdownMenuThemeData =
      DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(ColorsTheme.tertiaryDarker),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: ColorsTheme.tertiary, width: 1),
        ),
      ),
      elevation: WidgetStateProperty.all(8.0),
      shadowColor: WidgetStateProperty.all(ColorsTheme.black),
    ),
  );
}
