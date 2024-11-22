import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/auth.dart';
import 'package:skilluxfrontendflutter/services/STATE/auth_state/user_state.dart';
import 'package:skilluxfrontendflutter/services/notification_services/server_side_event/nontification_sse.dart';

Future<void> localLogout() async {
  final HiveTokenPersistence hiveTokenPersistence = Get.find();
  final AppStateManagment appStateManagement = Get.find();
  final TokenManager tokenManager = Get.find();
  final NotificationSse notificationSse = Get.find();

  await hiveTokenPersistence.deleteToken();
  await appStateManagement.updateState(isUserLogged: false);
  await tokenManager.reinitializeToken();
  notificationSse.disconnecFromTheStream();
  Get.off(() => const Auth());
  isUserLogginOut.value = false;
}
