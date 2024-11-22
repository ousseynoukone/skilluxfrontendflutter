import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final VoidCallback? ontap;
  final void Function(String)? onChange;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;

  const TextFormFieldComponent({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.ontap,
    this.onChange,
    this.readOnly = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
