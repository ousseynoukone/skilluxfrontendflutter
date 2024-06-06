import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class BottomSheetAppTheme {
  // private
  BottomSheetAppTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: ColorsTheme.white,
      modalBackgroundColor: ColorsTheme.white,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: ColorsTheme.black,
      modalBackgroundColor: ColorsTheme.black,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
}
