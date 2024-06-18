import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? edgeInsets;

  const ButtonComponent({
    super.key,
    required this.text,
    this.edgeInsets,
    required this.onPressed,
  });

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
        onPressed: onPressed,
        child: Text(
          text,
          style: textTheme.bodyMedium, // Adjust text style as needed
        ),
      ),
    );
  }
}
