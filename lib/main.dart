import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skilluxfrontendflutter/config/theme/theme.dart';
import 'package:skilluxfrontendflutter/core/utils/register_services.dart';
import 'package:skilluxfrontendflutter/generale_stream_language.dart';
import 'package:skilluxfrontendflutter/l10n/l10n.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/layers/primary_layer/primary_layer.dart';
import 'package:skilluxfrontendflutter/models/states/app_config_state.dart';
import 'dart:ui';

import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//-----INITIALIZING HIVE-----------
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(AppConfigStateAdapter());
  Hive.registerAdapter(UserAdapter());
// ---------END---------------------

  // Registering some needed getX services
  registerGetServices();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    GeneraleStreamLanguage.languageStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      stream: GeneraleStreamLanguage.languageStream.stream,
      builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
        Locale? locale = snapshot.data ?? defaultLangage();

        return GetMaterialApp(
          title: 'Skillux',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const PrimaryLayer(),
          supportedLocales: L10n.locals,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
