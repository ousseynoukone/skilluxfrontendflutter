import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/settings/settings.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/services/STATE/auth_state/user_state.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class PoppupMenuButton extends StatelessWidget {
  const PoppupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    GetXAuthController authController = GetXAuthController();

    return PopupMenuButtonComponent(
      menuItems: [
        CustomPopupMenuItem(
          value: "settings",
          text: text.settings,
          icon: const Icon(Icons.settings),
          onTap: () => Get.to(Settings()),
        ),
        CustomPopupMenuItem(
          value: "logout",
          text: text.logout,
          icon: const Icon(Icons.logout),
          onTap: () {
            Get.dialog(
              ConfirmationDialog(
                title: text.confirmLogOut,
                content: text.areYouSureLogOut,
                onConfirm: () {
                  isUserLogginOut.value = true;

                  // Add a small delay to ensure state propagation
                  Future.microtask(() {
                    authController.logout();
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
