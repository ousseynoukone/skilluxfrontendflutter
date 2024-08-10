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
        IconThemeData(color: ColorsTheme.tertiaryDarker, size: 20.0, fill: 1),
    unselectedIconTheme:
        IconThemeData(color: ColorsTheme.tertiaryDark, size: 20.0, fill: 1),
    selectedItemColor: ColorsTheme.tertiaryDarker,
    unselectedItemColor: ColorsTheme.tertiaryDark,
    selectedLabelStyle:
        TextStyle(color: ColorsTheme.tertiaryDarker, fontSize: 12),
    unselectedLabelStyle:
        TextStyle(color: ColorsTheme.tertiaryDark, fontSize: 12),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    enableFeedback:
        false, // Set enableFeedback to false to remove splash effect
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: ColorsTheme.tertiaryDarker,
    elevation: 8.0,
    selectedIconTheme: IconThemeData(color: ColorsTheme.tertiary, size: 20.0),
    unselectedIconTheme:
        IconThemeData(color: ColorsTheme.tertiaryLightDark, size: 20.0),
    selectedItemColor: ColorsTheme.tertiary,
    unselectedItemColor: ColorsTheme.tertiaryLightDark,
    selectedLabelStyle: TextStyle(color: ColorsTheme.tertiary, fontSize: 12),
    unselectedLabelStyle:
        TextStyle(color: ColorsTheme.tertiaryLightDark, fontSize: 12),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    enableFeedback:
        false, // Set enableFeedback to false to remove splash effect
  );
}
