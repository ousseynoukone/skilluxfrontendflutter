import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_response_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_register_dto.dart';
import 'package:skilluxfrontendflutter/models/internal_models/tokens/token.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/secondary_layer.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/auh_services/helpers/helpers.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

class GetXAuthController extends GetxController {
  // User API Service
  APIService apiService = Get.find();
  HiveUserPersistence userPersistence = Get.find();
  HiveTokenPersistence tokenPersistence = Get.find();
  final AppStateManagment _appStateManagement = Get.find();

  RxBool isLoading = false.obs;
  RxBool isSuccess = false.obs;
  RxBool sucessResetEmail = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  final NavigationBarController _navigationBarController = Get.find();
  final AppStateManagment _appStateManagmentController =
      Get.find<AppStateManagment>();

  void register(UserRegisterDto userRegisterDto) async {
    // Set loading state
    isLoading.value = true;

    String path = "auth/register/${await defaultLangage()}";
    try {
      ApiResponse response =
          await apiService.postRequest(path, data: userRegisterDto.toBody());
      // Handle the response
      if (response.statusCode == 201) {
        Map<String, dynamic> userData = response.body['user'];
        User user = User.fromBody(userData);
        await userPersistence.saveUser(user);

        // Return to Login
        isSuccess.value = true;
        _navigationBarController.setIndex(0);
      } else {
        // Handle errors
        if (response.body is Map<String, dynamic>) {
          // Multiple errors
          Map<String, dynamic> errors = response.body;

          // Iterate over the errors and display them
          errors.forEach((key, value) {
            if (value is String) {
              // Display each error message

              showCustomSnackbar(
                  title: text!.error,
                  message: value,
                  icon: Icons.error,
                  duration: const Duration(seconds: 7));
            } else {
              _logger.w("Unexpected error format for key: $key, value: $value");
            }
          });
        } else {
          // Handle unexpected error format
          showCustomSnackbar(
              title: text!.error,
              message: text!.errorUnexpected,
              icon: Icons.error,
              duration: const Duration(seconds: 7));
        }
      }

      // Reset loading state
      isLoading.value = false;
    } catch (e) {
      _logger.e(e);
    }
  }

  void login(UserLoginDto userLoginDto) async {
    // Set loading state

    String path = "auth/login/${await defaultLangage()}";
    isLoading.value = true;
    try {
      ApiResponse response =
          await apiService.postRequest(path, data: userLoginDto.toBody());

      if (response.statusCode == 200) {
        UserLoginResponseDto userLoginResponseDto =
            UserLoginResponseDto.fromBody(response.body);

        User? user = await userPersistence.readUser();
        user ??= userLoginResponseDto.user;
        await userPersistence.saveUser(user);
        Token token = Token(
            refreshTokenExpire: userLoginResponseDto.refreshTokenExpire,
            accessToken: userLoginResponseDto.accessToken,
            accessTokenExpire: userLoginResponseDto.accessTokenExpire,
            refreshToken: userLoginResponseDto.refreshToken);
        await tokenPersistence.saveToken(token);
        // update app login state
        _appStateManagmentController.updateState(isUserLogged: true);
        Get.off(() => const SecondaryLayer());
        // Set success state with user data
      } else {
        if (response.body is Map<String, dynamic>) {
          // Multiple errors
          Map<String, dynamic> errors = response.body;

          showCustomSnackbar(
            title: text!.error,
            message: errors['error'],
            icon: Icons.error,
          );
        }
      }

      isLoading.value = false;
    } catch (e) {
      _logger.e(e);
    }
  }

  void sendActivationEmail(String email) async {
    isLoading.value = true;

    String path = "auth/verify-email/${email}/${await defaultLangage()}";
    try {
      ApiResponse response = await apiService.getRequest(path);

      if (response.statusCode == 200) {
        Get.back();
        isSuccess.value = true;
      } else {
        if (response.body is Map<String, dynamic>) {
          // Multiple errors
          Map<String, dynamic> errors = response.body;
          if (response.statusCode == 403) {
            Get.back();
          }
          showCustomSnackbar(
            title: text!.error,
            message: errors['error'],
            icon: Icons.error,
          );
        }
      }

      isLoading.value = false;
    } catch (e) {
      _logger.e(e);
    }
  }

  void forgotPassword(String email) async {
    isLoading.value = true;

    String path = "auth/forgot-password";
    try {
      ApiResponse response =
          await apiService.postRequest(path, data: {"email": email});

      if (response.statusCode == 200) {
        sucessResetEmail.value = true;
        isSuccess.value = true;
        Get.back();
      } else {
        if (response.body is Map<String, dynamic>) {
          // Multiple errors
          Map<String, dynamic> errors = response.body;
          showCustomSnackbar(
            title: text!.error,
            message: errors['error'],
            icon: Icons.error,
          );
        }
      }
      isLoading.value = false;
    } catch (e) {
      _logger.e(e);
    }
  }

  void logout() async {
    isLoading.value = true;

    String path = "auth/logout";
    try {
      ApiResponse response = await apiService.getRequest(path);

      if (response.statusCode == 200) {
        await localLogout();
      } else if (response.statusCode == 401) {
        showCustomSnackbar(
            title: text!.alert,
            message: text!.reconnectMessage,
            icon: Icons.warning,
            duration: const Duration(seconds: 7));
      } else {
        if (response.body is Map<String, dynamic>) {
          // Multiple errors
          Map<String, dynamic> errors = response.body;

          showCustomSnackbar(
            title: text!.error,
            message: errors['error'],
            icon: Icons.error,
          );
          _logger.e(errors);
        }
      }
      isLoading.value = false;
    } catch (e) {
      _logger.e(e);
    }
  }
}