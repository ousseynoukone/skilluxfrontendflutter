import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/post_title_validator.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/image_handling.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/bottom_nav_bar.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
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
    with ImagePickerMixin, SectionBuilderMixin, RouteAware {
  var _stringTagController = StringTagController();
  final Logger _logger = Logger();
  final AddPostSysService _addPostSysService = Get.put(AddPostSysService());
  final TextEditingController _titleController = TextEditingController();
  final AddSectionSysService _addSectionSysService =
      Get.put(AddSectionSysService());
  final HivePostsPersistence _hivePostsPersistence =
      Get.put(HivePostsPersistence());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var text = Get.context!.localizations;

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  didPushNext() {
    savePost();
  }

  // Create a new post and broadcast it
  Future<void> savePost() async {
    Post newPost = Post(
        title: _titleController.text,
        tags: _stringTagController.getTags!,
        headerImageIMG: pickedImage,
        createdAt: DateTime.now(),
        content: _addSectionSysService.content.value);
    bool result = await newPost.convertXFileImageToBinary();
    if (result) {
      _addPostSysService.addPost(newPost);
    }
  }

  // Save post as draft
  Future<void> saveDraft() async {
    await savePost();
    if (_addPostSysService.post.value != null) {
      int result =
          await _hivePostsPersistence.addPost(_addPostSysService.post.value!);
      if (result != 0) {
        if (result == -1) {
          showCustomSnackbar(
              title: text.alert,
              message: text.bulkSaveAvoided,
              snackType: SnackType.warning,
              duration: const Duration(seconds: 5));
        } else {
          showCustomSnackbar(
              title: text.info,
              message: text.draftSaved,
              snackType: SnackType.success,
              duration: const Duration(seconds: 3));
        }
      } else {
        showCustomSnackbar(
            title: text.error,
            message: text.somethingWentWrong,
            snackType: SnackType.error,
            duration: const Duration(seconds: 5));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(text.createPublication),
          actions: const [PoppupMenuButton()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  buildImageWidget(context, text.addCoverPhoto),
                  const SizedBox(height: 22),
                  Form(
                    key: _formKey,
                    child: TextFieldComponent(
                      controller: _titleController,
                      labelText: text.title,
                      validator: (value) {
                        var message = PostTitleValidator.validate(value);
                        if (value == null || message != null) {
                          return message;
                        }
                        return null; // Return null if the input is valid
                      },
                      onChanged: (value) {
                        _formKey.currentState!.validate();
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                  TagsTextFieldComponent(
                    stringTagController: _stringTagController,
                  ),
                  const SizedBox(height: 22),
                  sectionBuilder()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            bottomNavBar(saveDraft, updatePostStream: savePost));
  }
}
