import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class SwitchAppTheme {
  // Private constructor to prevent instantiation
  SwitchAppTheme._();

  static SwitchThemeData lightSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // Disabled thumb color
        }
        return ColorsTheme.tertiaryDarker; // Default thumb color
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[300]; // Disabled track color
        }
        return ColorsTheme.tertiary; // Default track color
      },
    ),
    trackOutlineColor: WidgetStateProperty.all(Colors.grey[400]),
  );

  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[700]; // Disabled thumb color
        }
        return ColorsTheme.tertiary; // Default thumb color
      },
    ),
    trackColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[800]; // Disabled track color
        }
        return ColorsTheme.tertiaryLightDark; // Default track color
      },
    ),
    trackOutlineColor: WidgetStateProperty.all(Colors.grey[600]),
  );
}
