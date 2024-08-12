import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? edgeInsets;
  final bool isLoading;
  final bool applyTheme;

  const ButtonComponent(
      {super.key,
      required this.text,
      this.edgeInsets,
      required this.onPressed,
      this.applyTheme = false,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      padding: edgeInsets ??
          const EdgeInsets.symmetric(horizontal: 32.0, vertical: 9.0),
    );

    return SizedBox(
      width: double.infinity, // Make the button take full width
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                    color: applyTheme
                        ? Theme.of(context).colorScheme.primary
                        : ColorsTheme.primary),
              )
            : Text(
                text,
              ),
      ),
    );
  }
}
