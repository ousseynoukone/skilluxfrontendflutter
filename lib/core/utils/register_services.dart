import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';

Future<void> registerGetServices() async {
  // Registering some services
  Get.put(APIService());
  Get.put(HiveSettingsPersistence());
  Get.put(HiveUserPersistence()); 
  Get.put(HiveAppStatePersistence()); 
  Get.put(AppStateManagment()); 
}
