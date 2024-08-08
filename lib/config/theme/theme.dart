import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/app_bar_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/bottom_navigation_bar_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/dialog_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/dropdown_menu_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/poppup_menu_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/elevated_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/floating_action_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/input_decoration_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/outline_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/swtich_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/text_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/text_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/sheme_colors.dart';

import 'custom_themes/list_tile_theme.dart';

class AppTheme {
  // PRIVATE
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: ColorsTheme.primary,
          cursorColor: ColorsTheme.tertiaryDark,
          selectionColor: ColorsTheme.secondary),
      colorScheme: AppColorScheme.light,
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
      dialogTheme: DialogAppTheme.lightDialogButtonTheme,
      // listTileTheme: ListTileThemeAppTheme.listTileThemeDataLight,
      textButtonTheme: TextAppButtonTheme.lightTextButtonTheme);

  static ThemeData darkTheme = ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: ColorsTheme.primary,
          cursorColor: ColorsTheme.white,
          selectionColor: ColorsTheme.secondary),
      colorScheme: AppColorScheme.dark,
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
      dropdownMenuTheme: DropdownMenuAppTheme.darkDropdownMenuThemeData,
      dialogTheme: DialogAppTheme.darkDialogButtonTheme,
      // listTileTheme: ListTileThemeAppTheme.listTileThemeDataDark,
      
      textButtonTheme: TextAppButtonTheme.darkTextButtonTheme);
}
