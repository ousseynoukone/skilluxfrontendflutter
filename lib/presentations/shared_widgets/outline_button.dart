import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutlineButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? edgeInsets;
  final bool isLoading;
  final IconData? icon;
  final Color? iconColor;

  const OutlineButtonComponent({
    super.key,
    required this.text,
    this.edgeInsets,
    required this.onPressed,
    required this.isLoading,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: colorScheme.onSecondary,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color: iconColor,
                  ),
                if (icon != null) const SizedBox(width: 8),
                Text(text),
              ],
            ),
    );
  }
}
