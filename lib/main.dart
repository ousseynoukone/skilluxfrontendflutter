import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/theme.dart';
import 'package:skilluxfrontendflutter/core/utils/register_services.dart';

void main() async {
  // Registering some needed get services
  registerGetServices();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skillux',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
