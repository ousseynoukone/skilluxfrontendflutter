import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/app_bar_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/elevated_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/input_decoration_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/outline_button_theme.dart';
import 'package:skilluxfrontendflutter/config/theme/custom_themes/text_theme.dart';

class AppTheme {
  // PRIVATE
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: ColorsTheme.primary,
    scaffoldBackgroundColor:  ColorsTheme.white,
    textTheme: TextAppTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonAppTheme.elevatedButtonThemeDataLight,
    appBarTheme: AppBarAppTheme.lightAppBarTheme,
    bottomSheetTheme: BottomSheetAppTheme.lightBottomSheetTheme,
    inputDecorationTheme: InputDecorationAppTheme.lightInputDecorationTheme,
    outlinedButtonTheme: OutlineButtonAppTheme.lightOutlinedButtonTheme
  );


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: ColorsTheme.primary,
    scaffoldBackgroundColor: ColorsTheme.black,
    textTheme: TextAppTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonAppTheme.elevatedButtonThemeDataDark,
    appBarTheme: AppBarAppTheme.darkAppBarTheme,
    bottomSheetTheme: BottomSheetAppTheme.darkBottomSheetTheme,
    inputDecorationTheme: InputDecorationAppTheme.darktInputDecorationTheme,
    outlinedButtonTheme: OutlineButtonAppTheme.darkOutlinedButtonTheme

  );

}
