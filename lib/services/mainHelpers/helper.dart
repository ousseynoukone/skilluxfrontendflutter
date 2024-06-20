import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

String defaultLangage() {
  if (kIsWeb) {
    return  'en';
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
