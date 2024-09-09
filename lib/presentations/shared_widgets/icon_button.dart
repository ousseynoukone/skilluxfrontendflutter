import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final double? overideIconSize;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    required this.onPressed,
    this.isLoading = false,
    this.padding,
    this.overideIconSize,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var iconSize = Get.width * 0.07;

    return Stack(
      alignment: Alignment.center,
      children: [
        // The actual icon button
        IconButton(
          hoverColor: Colors.transparent,
          onPressed: isLoading ? null : onPressed,
          icon: Container(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              size: overideIconSize ?? iconSize,
              color: iconColor ?? colorScheme.onPrimary,
            ),
          ),
          color: iconColor ?? colorScheme.onPrimary,
          iconSize: iconSize,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        // The loading indicator
        if (isLoading)
          Positioned(
            child: SizedBox(
              height: iconSize,
              width: iconSize,
              child: const CircularProgressIndicator(
                color: ColorsTheme.secondary,
                strokeWidth: 3.0,
              ),
            ),
          ),
      ],
    );
  }
}
