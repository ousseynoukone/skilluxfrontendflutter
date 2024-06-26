import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/internal_models/states/app_config_state.dart';

class AppStateManagment extends GetxController {
  final HiveAppStatePersistence _hiveAppStatePersistence = Get.find();
  Rx<AppConfigState> appConfigState = AppConfigState().obs;
  
  @override
  Future<void> onInit() async {
    appConfigState.value = await _hiveAppStatePersistence.readState();
    super.onInit();
  }

  updateState({
    bool? isAppFirstLaunch,
    bool? isUserLogged,
  }) {
    appConfigState.update((value) {
      value?.isAppFirstLaunch =
          isAppFirstLaunch ?? appConfigState.value.isAppFirstLaunch;
      value?.isUserLogged = isUserLogged ?? appConfigState.value.isUserLogged;
    });

    // Save the updated state back to persistence
    _hiveAppStatePersistence.saveState(appConfigState.value);
  }

  @override
  void onClose() {
    appConfigState.close();
    super.onClose();
  }
}
