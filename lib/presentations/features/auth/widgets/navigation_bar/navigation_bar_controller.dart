import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  RxInt index = 0.obs; // Define index as a RxInt observable

  void setIndex(int newIndex) {
    index.value = newIndex; // Set the new value of index
  }
}
