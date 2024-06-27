import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/app_bar_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/bottom_navigation_bar_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/dropdown_menu_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/poppup_menu_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/elevated_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/floating_action_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/input_decoration_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/outline_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/swtich_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/text_theme.dart';

class AppTheme {
  // PRIVATE
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    splashColor: Colors.transparent,
    useMaterial3: true,
    fontFamily: "SF Pro",
    brightness: Brightness.light,
    primaryColor: ColorsTheme.primary,
    scaffoldBackgroundColor: ColorsTheme.white,
    textTheme: TextAppTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonAppTheme.elevatedButtonThemeDataLight,
    appBarTheme: AppBarAppTheme.lightAppBarTheme,
    bottomSheetTheme: BottomSheetAppTheme.lightBottomSheetTheme,
    inputDecorationTheme: InputDecorationAppTheme.lightInputDecorationTheme,
    outlinedButtonTheme: OutlineButtonAppTheme.lightOutlinedButtonTheme,
    bottomNavigationBarTheme:
        BottomAppNavigationBarTheme.lightBottomNavigationBarTheme,
    floatingActionButtonTheme:
        FloatingAppActionButtonTheme.lightFloatingActionButton,
    popupMenuTheme: PopupAppMenuTheme.lightPopupMenuTheme,
    switchTheme: SwitchAppTheme.lightSwitchTheme,
    dropdownMenuTheme: DropdownMenuAppTheme.lightDropdownMenuThemeData,
  );

  static ThemeData darkTheme = ThemeData(
      splashColor: Colors.transparent,
      useMaterial3: true,
      fontFamily: "SF Pro",
      brightness: Brightness.dark,
      primaryColor: ColorsTheme.primary,
      scaffoldBackgroundColor: ColorsTheme.black,
      textTheme: TextAppTheme.darkTextTheme,
      elevatedButtonTheme: ElevatedButtonAppTheme.elevatedButtonThemeDataDark,
      appBarTheme: AppBarAppTheme.darkAppBarTheme,
      bottomSheetTheme: BottomSheetAppTheme.darkBottomSheetTheme,
      inputDecorationTheme: InputDecorationAppTheme.darktInputDecorationTheme,
      outlinedButtonTheme: OutlineButtonAppTheme.darkOutlinedButtonTheme,
      bottomNavigationBarTheme:
          BottomAppNavigationBarTheme.darkBottomNavigationBarTheme,
      floatingActionButtonTheme:
          FloatingAppActionButtonTheme.darkFloatingActionButton,
      popupMenuTheme: PopupAppMenuTheme.darkPopupMenuTheme,
      switchTheme: SwitchAppTheme.darkSwitchTheme,
      dropdownMenuTheme: DropdownMenuAppTheme.darkDropdownMenuThemeData);
}
