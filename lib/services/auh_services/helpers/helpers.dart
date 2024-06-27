import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/auth.dart';

Future<void> localLogout() async {
  final HiveTokenPersistence _hiveTokenPersistence = Get.find();
  final AppStateManagment _appStateManagement = Get.find();
  final TokenManager _tokenManager = Get.find();

  await _hiveTokenPersistence.deleteToken();
 await  _appStateManagement.updateState(isUserLogged: false);
  await _tokenManager.reinitializeToken();
  Get.off(() => const Auth());
}
