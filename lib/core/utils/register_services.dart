import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar_controller.dart';

Future<void> registerGetServices() async {
  // Registering some services
  Get.put(HiveSettingsPersistence());
  Get.put(HiveUserPersistence()); 
  Get.put(HiveAppStatePersistence()); 
  Get.put(AppStateManagment()); 
  Get.put(APIService());
  
  // For handling Auth Top Navigation Bar
  Get.put(NavigationBarController());
  

}
