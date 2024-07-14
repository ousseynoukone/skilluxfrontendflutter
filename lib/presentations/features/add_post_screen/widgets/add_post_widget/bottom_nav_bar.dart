import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget bottomNavBar() {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  var text = AppLocalizations.of(Get.context!);

  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconTextButton(
            icon: Icons.save,
            label: text!.save,
            onPressed: () {
              // Save action
            },
          ),
          IconTextButton(
            icon: Icons.add,
            label: text.addSection,
            onPressed: () {
              Get.to(() => const AddSection());
            },
          ),
          IconTextButton(
            icon: Icons.visibility,
            label: text.preview,
            onPressed: () {
              // Preview action
            },
          ),
        ],
      ));
}
