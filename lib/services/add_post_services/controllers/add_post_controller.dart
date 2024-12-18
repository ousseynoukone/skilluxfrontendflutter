import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/constant/bottom_navigation_screen.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/secondary_layer.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/image_document_handling.dart';

class AddPostService extends GetxController {
  // User API Service
  APIService _apiService = Get.find();
  RxBool isLoading = false.obs;
  RxBool isSuccess = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;

  void addPost(Post post) async {
    isLoading.value = true;

    String path = "basic/posts";

    Post newPost = post.clone();

    await newPost.extractMediaFromContent();
    if (newPost.headerBinaryImage != null) {
      await newPost.convertHeaderImageBinaryToXFileImage();
      newPost.content.xFileMediaList.insert(0, newPost.headerImageIMG!);
    }

    // if (newPost.content.xFileMediaList.isNotEmpty) {
    ApiResponse response =
        await _apiService.multipartsPostSendRequest(path, newPost);
    if (response.statusCode == 201) {
      Get.offAll(() => SecondaryLayer(
            index: bnScreensList.length - 1,
          ));

      showCustomSnackbar(
          title: text!.info,
          message: response.message!,
          snackType: SnackType.success);
    } else {
      showCustomSnackbar(
          title: text!.error,
          message: response.message ?? "",
          snackType: SnackType.error);
    }
    // } else {
    //   _logger.i("arrayOfImage is empty");
    // }

    isLoading.value = false;
  }
}
