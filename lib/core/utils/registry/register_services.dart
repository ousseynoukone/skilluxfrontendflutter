import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/foreign_profile_post_holder/foreign_profile_post_holder.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/notification_services/server_side_event/nontification_sse.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/like_service.dart';
import 'package:skilluxfrontendflutter/services/profile_services/controllers/settings_controller.dart';
import 'package:skilluxfrontendflutter/services/translator_services/translator_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_update_service.dart';
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

  // User service
  Get.put(UserService());

  // For ForeignProfilePostHolder
  Get.put(ForeignProfilePostHolder());

  // For like
  Get.put(LikeService());

  // For the upcoming notification number of the connected user
  Get.put(NotificationSse());
}
