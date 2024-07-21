import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';

class AddSectionSysService extends GetxController {
  RxString content = "".obs;

  void clearContent() {
    content.value = "";
  }
}