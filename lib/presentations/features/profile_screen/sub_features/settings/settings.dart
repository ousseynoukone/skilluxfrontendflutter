import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/services/profile_services/controllers/settings_controller.dart';

class Settings extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(text.settings),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(text.dark_mode),
            trailing: Obx(() => Switch(
                  value: settingsController.isDarkMode.value,
                  onChanged: (value) {
                    settingsController.toggleTheme();
                  },
                )),
          ),
          ListTile(
            title: Text(text.change_language),
            trailing: DropdownButton<String>(
              dropdownColor: Get.isDarkMode
                  ? ColorsTheme.tertiaryMidDarker
                  : ColorsTheme.white,
              value: settingsController.selectedLocale.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  settingsController.changeLocale(newValue);
                }
              },
              items: <String>['en', 'fr']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value == 'en' ? 'English' : 'Français',
                    style: textTheme.labelLarge,
                  ),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text(text.delete_account),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                settingsController.deleteAccount();
              },
            ),
          ),
        ],
      ),
    );
  }
}
