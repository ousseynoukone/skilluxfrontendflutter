import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/draft.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';

class PoppupMenuButton extends StatelessWidget {
  const PoppupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    return PopupMenuButtonComponent(menuItems: [
      CustomPopupMenuItem(
          value: 'draft',
          text: text.draft,
          onTap: () {
            Get.to(() => const Draft());
          }),
    ]);
  }
}
