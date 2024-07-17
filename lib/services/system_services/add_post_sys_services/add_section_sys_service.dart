import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';

class AddSectionSysService extends GetxController {
  RxList<Section> sections = <Section>[].obs;

  void addSection(Section section) {
    sections.add(section);
  }

  void updateSection(int index, Section updatedSection) {
    if (index >= 0 && index < sections.length) {
      sections[index] = updatedSection;
    }
  }

  void removeSection(int index) {
    if (index >= 0 && index < sections.length) {
      sections.removeAt(index);
    }
  }

  void clearSections() {
    sections.clear();
  }
}