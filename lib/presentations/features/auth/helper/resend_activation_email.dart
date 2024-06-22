import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';

Future<void> resendActivationEmail() async {
  HiveUserPersistence userPersistence = Get.find();
  final GetXAuthController _getXAuthController = Get.find();
  User? user = await userPersistence.readUser();

  final text = Get.context?.localizations;

  if (user?.email == null) {
    Get.snackbar(text!.error, text.createAccount,
        snackPosition: SnackPosition.BOTTOM);
  } else {
     _getXAuthController.sendActivationEmail(user!.email);
  }
}
