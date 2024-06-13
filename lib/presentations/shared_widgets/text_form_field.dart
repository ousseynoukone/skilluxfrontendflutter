import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const TextFormFieldComponent({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
