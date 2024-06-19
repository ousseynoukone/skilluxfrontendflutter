import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/core/utils/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_response_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_register_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/response_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

class GetXAuthController extends GetxController {
  // User API Service
  APIService apiService = Get.find();
  HiveUserPersistence userPersistence = Get.find();
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;




  void register(UserRegisterDto userRegisterDto) async {
    // Set loading state
    isLoading.value = true;
    String path = "auth/register";

    ApiResponse response =
        await apiService.postRequest(path, data: userRegisterDto.toBody());

    // Handle the response
    if (response.statusCode == 201) {
      User user = User.fromBody(response.body);
      await userPersistence.saveUser(user);
      Get.to(() => const Login());
    } else {
      // Handle errors
      if (response.body.containsKey('error')) {
        Map<String, dynamic> errors = response.body['error'];

        // Iterate over the errors and display them
        errors.forEach((key, value) {
          if (value is String) {
            // Display each error message, you can use a dialog, snackbar, or any other method
            Get.snackbar(text!.error, value,
                snackPosition: SnackPosition.BOTTOM);
          }
        });
      } else {
        // Handle unexpected error format
        Get.snackbar(text!.error, text!.errorUnexpected,
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    // Reset loading state
    isLoading.value = false;
  }

  void login(UserLoginDto userLoginDto) async {
    // Set loading state

    String path = "auth/login";
    isLoading.value = true;

    ApiResponse response =
        await apiService.postRequest(path, data: userLoginDto);

    if (response.statusCode == 201) {
      UserLoginResponseDto userLoginResponseDto =
          UserLoginResponseDto.fromBody(response.body);
      User user = await userPersistence.readUser();
      user.token = userLoginResponseDto.token;
      user.expire = userLoginResponseDto.expire;

      await userPersistence.saveUser(user);

      // Set success state with user data
    } else {
      // Handle errors
      if (response.body.containsKey('error')) {
        Map<String, dynamic> errors = response.body['error'];

        // Iterate over the errors and display them
        errors.forEach((key, value) {
          if (value is String) {
            // Display each error message, you can use a dialog, snackbar, or any other method
            Get.snackbar(text!.error, value,
                snackPosition: SnackPosition.BOTTOM);
          }
        });
      } else {
        // Handle unexpected error format
        Get.snackbar(text!.error, text!.errorUnexpected,
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    isLoading.value = true;
  }

  void forgotPassword(String email) async {
    String path = "auth/forgot-password";
    ApiResponse response =
        await apiService.postRequest(path, data: {"email": email});

    if (response.statusCode == 200) {
      Get.snackbar(text!.alert, text!.forgotPasswordEmail,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Handle errors
      if (response.body.containsKey('error')) {
        Map<String, dynamic> errors = response.body['error'];

        // Iterate over the errors and display them
        errors.forEach((key, value) {
          if (value is String) {
            // Display each error message, you can use a dialog, snackbar, or any other method
            Get.snackbar(text!.error, value,
                snackPosition: SnackPosition.BOTTOM);
          }
        });
      } else {
        // Handle unexpected error format
        Get.snackbar(text!.error, text!.errorUnexpected,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
