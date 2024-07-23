import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextFieldComponent extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)?
      onChanged; // Changed to accept a String parameter

  const TextFieldComponent({
    super.key,
    required this.labelText,
    required this.controller,
    this.decoration,
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var themeText = context.textTheme;

    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      decoration: decoration ??
          InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            hintText: hintText,
            labelStyle: themeText.titleMedium?.copyWith(
                color: colorScheme.onSecondary, fontWeight: FontWeight.w600),
            floatingLabelStyle: themeText.titleMedium?.copyWith(
                color: colorScheme.onSecondary, fontWeight: FontWeight.w600),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.onSurface),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsTheme.secondary, width: 2),
            ),
          ),
    );
  }
}
