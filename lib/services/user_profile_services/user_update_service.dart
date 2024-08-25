import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';
import 'package:logger/logger.dart';

class UserUpdateService extends GetXAuthController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();
  RxBool isLoading = false.obs;

  Future<void> updateUserPP(XFile image) async {
    String path = "basic/update-user-profile-picture";
    String fieldName = "profilePicture";
    try {
      isLoading.value = true;

      await _apiService.singleMediaPostRequest(path, image, fieldName);
      Get.back();

      showCustomSnackbar(
          title: text!.info,
          message: text!.sucess,
          snackType: SnackType.success);
    } catch (e) {
      showCustomSnackbar(
          title: text!.error,
          message: text!.errorUnexpected,
          snackType: SnackType.error);

      _logger.e(e);
      // Handle error state if needed
    } finally {
      isLoading.value = false;
    }
  }
}
