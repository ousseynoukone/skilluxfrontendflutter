import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final VoidCallback? ontap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  const TextFormFieldComponent(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      required this.controller,
      this.validator,
      this.ontap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon),
    );
  }
}
