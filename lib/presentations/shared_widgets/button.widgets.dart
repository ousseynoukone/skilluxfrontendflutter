import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  // final Color color;
  final VoidCallback onPressed;

  final EdgeInsets? edgeInsets;

  const ButtonComponent({
    super.key,
    required this.text,
    this.edgeInsets,
    // this.color = Colors.blue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
        edgeInsets ??
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 9.0),
      )),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
