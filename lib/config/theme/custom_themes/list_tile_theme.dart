import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/text_theme.dart';

class ListTileThemeAppTheme {
  // private
  ListTileThemeAppTheme._();

  // Light theme for ListTile
  static final ListTileThemeData listTileThemeDataLight =
      ListTileThemeData(titleTextStyle: TextAppTheme.lightTextTheme.bodyMedium);

  // Dark theme for ListTile
  static final ListTileThemeData listTileThemeDataDark =
      ListTileThemeData(titleTextStyle: TextAppTheme.darkTextTheme.bodyMedium);
}
