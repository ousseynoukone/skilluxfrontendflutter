import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

import '../../config/theme/colors.dart';

class Skillux extends StatelessWidget {
  final double heightDivider;
  final double widthDivider;
  const Skillux(
      {super.key, required this.heightDivider, required this.widthDivider});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var text = context.localizations;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logos/skillux_logo_no_bg.png",
          width: Get.width / widthDivider,
          height: Get.width / heightDivider,
        ),
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: text.skill,
              style:
                  textTheme.titleLarge?.copyWith(color: ColorsTheme.primary)),
          TextSpan(
              text: text.ux,
              style:
                  textTheme.titleLarge?.copyWith(color: ColorsTheme.secondary)),
        ]))
      ],
    );
  }
}
