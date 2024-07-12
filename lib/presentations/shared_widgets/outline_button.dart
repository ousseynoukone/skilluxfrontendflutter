import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutlineButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? edgeInsets;
  final bool isLoading;
  const OutlineButtonComponent(
      {super.key,
      required this.text,
      this.edgeInsets,
      required this.onPressed,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: colorScheme.onSecondary,
                ),
              )
            : Text(
                text,
              ),
      ),
    );
  }
}
