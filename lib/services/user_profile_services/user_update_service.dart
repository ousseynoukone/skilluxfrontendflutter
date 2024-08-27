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

  Future<void> updateUserInfos(
      String fullname, String profession, String email) async {
    String path = "basic/update-user";
    try {
      isLoading.value = true;

      var data = {
        'fullName': fullname,
        'profession': profession,
        'email': email
      };

      var response = await _apiService.postRequest(path, data: data);
      if (response.statusCode == 200) {
        Get.back();

        showCustomSnackbar(
            title: text!.info,
            message: text!.sucess,
            snackType: SnackType.success);
      } else {
        _logger.e(
            "Error response: ${response.body}"); // Log response body for more details

        showCustomSnackbar(
            title: "${text!.error} : ${response.statusCode}",
            message: text!.errorUnexpected,
            snackType: SnackType.error);
      }
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
