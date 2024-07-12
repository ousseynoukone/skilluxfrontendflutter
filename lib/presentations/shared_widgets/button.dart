import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? edgeInsets;
  final bool isLoading;
  const ButtonComponent(
      {super.key,
      required this.text,
      this.edgeInsets,
      required this.onPressed,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity, // Make the button take full width
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            edgeInsets ??
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 9.0),
          ),
          // Optionally, you can add more styling here such as background color, etc.
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: ColorsTheme.primary,
                ),
              )
            : Text(
                text,
              ),
      ),
    );
  }
}
