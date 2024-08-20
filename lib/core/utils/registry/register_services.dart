import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:skilluxfrontendflutter/services/profile_services/controllers/settings_controller.dart';
import 'package:skilluxfrontendflutter/services/translator_services/translator_service.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';

Future<void> registerGetServices() async {
  // Registering some services
  Get.put(HiveSettingsPersistence());

  // Create instance of HiveUserPersistence and wait for initialization
  HiveUserPersistence hiveUserPersistence = Get.put(HiveUserPersistence());
  await hiveUserPersistence.onInit();

  // Create instance of HiveTokenPersistence and wait for initialization

  final HiveTokenPersistence hiveTokenPersistence =
      Get.put(HiveTokenPersistence());
  await hiveTokenPersistence.onInit();

  Get.put(HiveAppStatePersistence());
  Get.put(AppStateManagment());

  Get.put(TokenManager());

  Get.put(APIService());

  // Create instance of SettingsController and wait for initialization
  final settingsController = Get.put(SettingsController());
  await settingsController.onInit();

  // For handling Auth Top Navigation Bar
  Get.put(NavigationBarController());

  // For handling Translation
  Get.put(TranslatorService());

  //Handling post drafts
  Get.put(HivePostsPersistence());

  Get.put(UserService());

}
