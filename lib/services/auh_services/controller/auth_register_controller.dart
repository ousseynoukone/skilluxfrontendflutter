import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/core/utils/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_login_response_dto.dart';
import 'package:skilluxfrontendflutter/models/dtos/auth_dtos/user_register_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

class GetXAuthController extends GetxController with StateMixin<User> {
  // User API Service
  APIService apiService = Get.find();
  HiveUserPersistence userPersistence = Get.find();

  void register(UserRegisterDto userRegisterDto) async {
    // Set loading state
    change(null, status: RxStatus.loading());

    String path = "auth/register";

    ApiResponse response =
        await apiService.postRequest(path, data: userRegisterDto);

    if (response.statusCode == 201) {
      User user = User.fromBody(response.body);
      await userPersistence.saveUser(user);
      // Set success state with user data
      change(user, status: RxStatus.success());
    } else {
      // Set error state with error message
      change(null, status: RxStatus.error(response.message));
    }
  }

  void login(UserLoginDto userLoginDto) async {
    // Set loading state
    change(null, status: RxStatus.loading());

    String path = "auth/login";

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
      change(user, status: RxStatus.success());
    } else {
      // Set error state with error message
      change(null, status: RxStatus.error(response.message));
    }
  }

  void forgotPassword(String email) async {
    change(null, status: RxStatus.loading());
    String path = "auth/forgot-password";
    ApiResponse response =
        await apiService.postRequest(path, data: {"email": email});

    if (response.statusCode == 200) {
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(response.message));
    }
  }
}
