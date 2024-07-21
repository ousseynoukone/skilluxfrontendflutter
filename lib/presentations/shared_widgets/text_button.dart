import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final Color ? iconColor;
  final String ? label;
  final VoidCallback ? onPressed;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? iconSize;
  final double? fontSize;
  final bool isLoading;

  const IconTextButton({
    Key? key,
    required this.icon,
    this.label,
    this.iconColor,
    required this.onPressed,
    this.textColor,
    this.padding,
    this.iconSize,
    this.fontSize,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      label: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: ColorsTheme.primary),
            )
          : Text(
              label ?? "",
              style: TextStyle(
                color: textColor ??
                    Theme.of(context).textTheme.labelSmall?.backgroundColor,
                fontSize: fontSize,
              ),
            ),
      style: TextButton.styleFrom(
        padding: padding ??
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
