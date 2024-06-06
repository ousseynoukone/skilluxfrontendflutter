import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class InputDecorationAppTheme {
  //private
  InputDecorationAppTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ColorsTheme.tertiary,
    suffixIconColor: ColorsTheme.tertiary,
    labelStyle:
        const TextStyle().copyWith(fontSize: 14, color: ColorsTheme.black),
    hintStyle:
        const TextStyle().copyWith(fontSize: 14, color: ColorsTheme.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ColorsTheme.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(width: 1, color: ColorsTheme.tertiary)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.tertiary)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.black)),
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
    hintStyle:
        const TextStyle().copyWith(fontSize: 14, color: ColorsTheme.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: ColorsTheme.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(width: 1, color: ColorsTheme.tertiary)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.tertiary)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.white)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: ColorsTheme.error2)),
  );
}
