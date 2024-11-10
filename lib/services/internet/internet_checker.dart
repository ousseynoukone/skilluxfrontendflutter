import 'package:connection_notifier/connection_notifier.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';

class InternetChecker extends GetxController {
  @override
  onInit() {
    super.onInit();

    listenInternetChange();
  }

  listenInternetChange() async {
    var text = Get.context!.localizations;

    await ConnectionNotifierTools.initialize();

    ConnectionNotifierTools.onStatusChange.listen((data) {
      if (!data) {
        showCustomSnackbar(
            title: text.info,
            message: text.noInternet,
            permanent: true,
            isDismissible: false,
            snackPosition: SnackPosition.BOTTOM,
            snackType: SnackType.warning);
      } else {
        if (Get.isSnackbarOpen) {
          Get.back();
        }
      }
    });
  }
}
