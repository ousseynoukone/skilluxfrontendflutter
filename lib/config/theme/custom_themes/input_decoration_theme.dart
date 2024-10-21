import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class InputDecorationAppTheme {
  //private
  InputDecorationAppTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ColorsTheme.black,
    suffixIconColor: ColorsTheme.black,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14, color: ColorsTheme.black),
    hintStyle: const TextStyle()
        .copyWith(fontSize: 12, color: ColorsTheme.black.withOpacity(0.8)),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ColorsTheme.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.black)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.black)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.secondary)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error2)),
  );

  static InputDecorationTheme darktInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ColorsTheme.tertiary,
    suffixIconColor: ColorsTheme.tertiary,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14, color: ColorsTheme.white),
    hintStyle: const TextStyle().copyWith(
      fontSize: 12,
      color: ColorsTheme.white.withOpacity(0.8),
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.white)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.white)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.secondary)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error2)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error)),
  );
}
