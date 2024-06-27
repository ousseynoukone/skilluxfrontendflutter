import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class BottomAppNavigationBarTheme {
  // Private constructor to prevent instantiation
  BottomAppNavigationBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: ColorsTheme.white,
    elevation: 8.0,
    selectedIconTheme:
        IconThemeData(color: ColorsTheme.tertiaryDarker, size: 30.0, fill: 1),
    unselectedIconTheme:
        IconThemeData(color: ColorsTheme.tertiaryDark, size: 24.0, fill: 0.0),
    selectedItemColor: ColorsTheme.tertiaryDarker,
    unselectedItemColor: ColorsTheme.tertiaryDark,
    selectedLabelStyle: TextStyle(
        color: ColorsTheme.tertiaryDarker, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(color: ColorsTheme.tertiaryDark,fontSize: 14),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    enableFeedback: true,
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: ColorsTheme.tertiaryDarker,
    elevation: 8.0,
    selectedIconTheme: IconThemeData(color: ColorsTheme.tertiary, size: 30.0),
    unselectedIconTheme:
        IconThemeData(color: ColorsTheme.tertiaryLightDark, size: 24.0),
    selectedItemColor: ColorsTheme.tertiary,
    unselectedItemColor: ColorsTheme.tertiaryLightDark,
    selectedLabelStyle:
        TextStyle(color: ColorsTheme.tertiary, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(color: ColorsTheme.tertiaryLightDark,fontSize: 14),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    enableFeedback: true,
    
  );
}
