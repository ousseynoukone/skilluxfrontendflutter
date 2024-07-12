import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class DialogAppTheme {
  // private
  DialogAppTheme._();

  static final lightDialogButtonTheme = DialogTheme(
    elevation: 1,
    backgroundColor: ColorsTheme.tertiary,
    titleTextStyle: const TextStyle(
      fontSize: 16,
      color: ColorsTheme.black,
      fontWeight: FontWeight.w800,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      color: ColorsTheme.black,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  );

  static final darkDialogButtonTheme = DialogTheme(
    elevation: 1,
    backgroundColor: ColorsTheme.tertiaryDarker,
    titleTextStyle: const TextStyle(
      fontSize: 16,
      color: ColorsTheme.tertiary,
      fontWeight: FontWeight.w800,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      color: ColorsTheme.tertiary,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  );
}
