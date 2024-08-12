import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var iconSize = Get.width * 0.07;
    return IconButton(
      hoverColor: Colors.transparent,
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: ColorsTheme.secondary),
            )
          : Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color:
                    colorScheme.primary, // Use primary color from colorScheme
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ??
                    colorScheme
                        .onPrimary, // Use onPrimary color from colorScheme for icon color
              ),
            ),
      color: iconColor ??
          colorScheme.onPrimary, // Use onPrimary color for icon color
      iconSize: iconSize,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      // padding: EdgeInsets.zero,
      // constraints: BoxConstraints(),
    );
  }
}
