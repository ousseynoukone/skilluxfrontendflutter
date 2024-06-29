import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/internal_models/settings/setting.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

class SettingsController extends GetxController {
  late RxBool isDarkMode;
  late RxString selectedLocale;
  final HiveSettingsPersistence _hiveSettingsPersistence = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    // Initialize reactive variables
    isDarkMode = isSystemDarkMode().obs; // Initialize with system theme mode
    selectedLocale = ''.obs; // Default language

    // Load settings from persistent storage
    await loadSettings();
  }

  bool isSystemDarkMode() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  Future<void> loadSettings() async {
    // Load settings from persistent storage
    Setting? settings = await _hiveSettingsPersistence.readSettings();
    if (settings != null) {
      if (settings.themeMode != null) {
        isDarkMode.value = settings.themeMode!;
        Get.changeThemeMode(
            isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      } 
    } 

    // Initialize selectedLocale with default language
    selectedLocale.value = await defaultLangage();
    Get.updateLocale(Locale(selectedLocale.value));
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveSettings();
  }

  void changeLocale(String locale) {
    Get.updateLocale(Locale(locale));
    selectedLocale.value = locale;
    saveSettings();
  }

  Future<void> saveSettings() async {
    Setting settings = Setting(
      lang: selectedLocale.value,
      themeMode: isDarkMode.value,
    );
    await _hiveSettingsPersistence.saveSettings(settings);
  }
}
