import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/auth.dart';
import 'package:skilluxfrontendflutter/presentations/onBoard/on_boarding_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loading.dart';

class PrimaryLayer extends StatefulWidget {
  const PrimaryLayer({super.key});

  @override
  State<PrimaryLayer> createState() => _PrimaryLayerState();
}

class _PrimaryLayerState extends State<PrimaryLayer> {
  final AppStateManagment controller = Get.find<AppStateManagment>();

  late Future<void> _initStateFuture;

  @override
  void initState() {
    super.initState();
    _initStateFuture = controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    var _text = context.localizations;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initStateFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingAnimation();
            } else if (snapshot.hasError) {
              return const Text('Error loading state');
            } else {
              return Obx(() {
                // IF APP IS LAUNCHED FOR THE FIRST TIME
                if (controller.appConfigState.value.isAppFirstLaunch == true) {
                  controller.updateState(isAppFirstLaunch: false);
                  return const OnBoardingScreen();
                }
                // IF USER NOT LOGGED
                if (controller.appConfigState.value.isUserLogged == false) {
                  return const Auth();
                }
      
                return const SizedBox.shrink();
              });
            }
          },
        ),
      ),
    );
  }
}
