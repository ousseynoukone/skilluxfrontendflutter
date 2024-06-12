import 'dart:async';

import 'package:flutter/material.dart';

class GeneraleStreamLanguage {
  const GeneraleStreamLanguage._();

  static StreamController<Locale> languageStream = StreamController.broadcast();
  
}
