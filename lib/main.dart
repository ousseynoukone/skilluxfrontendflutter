import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skilluxfrontendflutter/config/theme/theme.dart';
import 'package:skilluxfrontendflutter/core/utils/registry/register_hive_adapter.dart';
import 'package:skilluxfrontendflutter/core/utils/registry/register_services.dart';
import 'package:skilluxfrontendflutter/l10n/l10n.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:skilluxfrontendflutter/presentations/layers/primary_layer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


//-----INITIALIZING HIVE-----------
  await Hive.initFlutter();

  // Register the adapter
  registerHiveAdapter();
// ---------END---------------------

  // Registering some needed getX services
  await registerGetServices();


  

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
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skillux',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const PrimaryLayer(),
      supportedLocales: L10n.locals,
      // locale: Locale('en'), LOCAL ARE INITIALIZE AT PRIMARY LAYER
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
