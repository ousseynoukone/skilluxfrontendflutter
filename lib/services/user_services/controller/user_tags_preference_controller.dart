import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/models/tag/tag.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/secondary_layer.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/translator_services/translator_service.dart';

class GetXUserTagsPreference extends GetxController with StateMixin<List<Tag>> {
  // User API Service
  final APIService _apiService = Get.find();
  final AppStateManagment _appStateManagment = Get.find();
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  List<Tag> tags = [];
  final TranslatorService _translatorService = Get.find();

    @override
  void onInit() {
    super.onInit();
    getTagsPreferences();
  }

  void getTagsPreferences() async {
    String path = "basic/tags";

    try {
      change(tags, status: RxStatus.loading());

      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        var data = response.body;
        if (data.isEmpty) {
          change(tags, status: RxStatus.empty());
        }
        tags = (data as List).map((tag) => Tag.fromBody(tag)).toList();
        if (tags.isNotEmpty) {
          tags = await _translatorService.translateTags(tags);
          change(tags, status: RxStatus.success());
        }
      }
    } catch (e) {
      _logger.e(e);
      change(tags, status: RxStatus.error(e.toString()));
    }
  }

  void setUsersPreferences(List<int> ids) async {
    String path = "basic/update_user_preferences";
    isLoading.value = true;
    try {
      ApiResponse response =
          await _apiService.postRequest(path, data: {"tags": ids});
      if (response.statusCode == 201) {
        showCustomSnackbar(title: text!.info, message: text!.userPrefSaved);
        await _appStateManagment.updateState(isUserTagsPreferenceSaved: true);
        Get.off(() => const SecondaryLayer());
      }
    } catch (e) {
      _logger.e(e);
      change(tags, status: RxStatus.error(e.toString()));
    }

    isLoading.value = false;
  }
}
