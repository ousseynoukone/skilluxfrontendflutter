import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/settings/setting.dart';

String defaultLocalLangage() {
  if (kIsWeb) {
    return 'en';
  }
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.fuchsia) {
    String defaultLocale =
        Platform.localeName; // Returns locale string in the form 'en_US'
    if (defaultLocale.contains('en') || defaultLocale.isEmpty) {
      return 'en';
    } else {
      return 'fr';
    }
  } else {
    return 'en';
  }
}

Future<String> defaultLangage() async {
  final HiveSettingsPersistence _hiveSettingsPersistence = Get.find();
  Setting? settings = await _hiveSettingsPersistence.readSettings();
  return settings?.lang ?? defaultLocalLangage();
}
