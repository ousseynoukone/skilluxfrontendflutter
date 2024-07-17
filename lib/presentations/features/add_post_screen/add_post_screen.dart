import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/image_handling.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/bottom_nav_bar.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/tags_text_field.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_field.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:logger/logger.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen>
    with ImagePickerMixin {
  var _stringTagController = StringTagController();
  final Logger _logger = Logger();
  AddPostSysService addPostSysService = Get.put(AddPostSysService());
  final TextEditingController _titleController = TextEditingController();
  AddSectionSysService addSectionSysService = Get.put(AddSectionSysService());

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }



  // Create a new post and broadcast it
  void savePost() {
    Post newpost = Post(
        title: _titleController.text,
        tags: _stringTagController.getTags!,
        headerImageIMG: pickedImage,
        sections: addSectionSysService.sections);
    addPostSysService.addPost(newpost);
  }

 

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(text.createPublication),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  buildImageWidget(context, text.addMedia),
                  const SizedBox(height: 22),
                  TextFieldComponent(
                    controller: _titleController,
                    labelText: text.title,
                  ),
                  const SizedBox(height: 22),
                  TagsTextFieldComponent(
                    stringTagController: _stringTagController,
                  ),
                  const SizedBox(height: 22),
                  sectionBuilder(addSectionSysService.sections)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavBar(savePost));
  }
}
