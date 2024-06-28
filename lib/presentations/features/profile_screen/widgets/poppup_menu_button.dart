import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/settings/settings.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

class PoppupMenuButton extends StatefulWidget {
  const PoppupMenuButton({super.key});

  @override
  State<PoppupMenuButton> createState() => _PoppupMenuButtonState();
}

class _PoppupMenuButtonState extends State<PoppupMenuButton> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var text = context.localizations;
    GetXAuthController authController = GetXAuthController();

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == "settings") {
          Get.to(Settings());
        } else if (value == "logout") {
          Get.dialog(
            ConfirmationDialog(
              title: text.confirmLogOut,
              content: text.areYouSureLogOut,
              onConfirm: () {
                authController.logout();
              },
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: "settings",
          child: Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.settings)),
              Text(
                text.settings,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "logout",
          child: Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.logout)),
              Text(
                text.logout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
