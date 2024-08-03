import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/draft.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

class PoppupMenuButton extends StatelessWidget {
  const PoppupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPostSysService _addPostSysService = Get.find();

    var text = context.localizations;
    return PopupMenuButtonComponent(menuItems: [
      CustomPopupMenuItem(
          value: 'draft',
          icon: const Icon(Icons.save),
          text: text.draft,
          onTap: () {
            Get.to(() => const Draft());
          }),
      CustomPopupMenuItem(
          value: 'clearPost',
          icon: const Icon(Icons.delete),
          text: text.clearPost,
          onTap: () {
            _addPostSysService.clearPost();
          }),
    ]);
  }
}
