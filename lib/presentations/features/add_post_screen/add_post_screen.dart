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
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:logger/logger.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen>
    with ImagePickerMixin, SectionBuilderMixin, RouteAware {
  final Logger _logger = Logger();
  final AddPostSysService _addPostSysService = Get.put(AddPostSysService());
  final TextEditingController _titleController = TextEditingController();
  final HivePostsPersistence _hivePostsPersistence =
      Get.put(HivePostsPersistence());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var text = Get.context!.localizations;
  final List<String> tagsListe = [];
  AddPostSysService addPostSysService = Get.find();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    super.initState();
    listenForSelectedDraftPost();
    clearField();
  }

//While living this screen
  @override
  didPushNext() {
    updatePostStream();
  }

  //If this screen pop again
  @override
  didPopNext() {}

  @override
  void dispose() {
    super.dispose();
    disposeAll();
  }

  //Listen for selected draft post
  listenForSelectedDraftPost() {
    _addPostSysService.isFromDraft.listen((value) {
      fillPostFields();
      _addPostSysService.rebuildTagFieldToDisplayTags();
    });
  }

  // Listen for clearing field
  clearField() {
    _addPostSysService.clearPostField.listen((value) {
      _titleController.clear();
      pickedImage = null;
      _addPostSysService.rebuildTagFieldToDisplayTags(isForClear: true);
    });
  }

// Function that allow a post draft to be displayed here
  fillPostFields() async {
    Post? post = _addPostSysService.post.value;
    if (_addPostSysService.isPostNotEmpty(checkHeaderImage: false)) {
      await post.convertheaderImageBinaryToXFileImage();
      _titleController.text = post.title;
      pickedImage = post.headerImageIMG;
    }
  }

  disposeAll() {
    _addPostSysService.clearPost();
    _addPostSysService.clearContent();
    _titleController.dispose();
  }

  // Create a new post and broadcast it
  Future<void> updatePostStream() async {
    try {
      Post newPost = Post(
          id: _addPostSysService.post.value.id,
          title: _titleController.text,
          tags: _addPostSysService.post.value.tags,
          headerImageIMG: pickedImage,
          createdAt: DateTime.now(),
          content: _addPostSysService.post.value.content);
      bool result = await newPost.convertheaderImageXFileImageToBinary();
      if (result) {
        _addPostSysService.addPost(newPost);
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  // Save post as draft
  Future<void> saveDraft() async {
    await updatePostStream();
    if (_addPostSysService.isPostNotEmpty(showError: true)) {
      addPostSysService.isLoading.value = true;

      Post post = _addPostSysService.post.value;
      bool result = await post.convertxFileMediaListToBinary();
      if (result) {
        int result = await _hivePostsPersistence.addPost(post);
        addPostSysService.isLoading.value = false;

        if (result != 0) {
          if (result == -2) {
            showCustomSnackbar(
                title: text.alert,
                message: text.bulkSaveAvoided,
                snackType: SnackType.warning,
                duration: const Duration(seconds: 5));
          } else if (result == -1) {
            showCustomSnackbar(
                title: text.info,
                message: text.draftUpdated,
                snackType: SnackType.success,
                duration: const Duration(seconds: 3));
          } else if (result == 1) {
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
    } else {
      _logger.e("Error while running convertxFileMediaListToBinary");
    }
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
                  Obx(() {
                    Widget tagWidget;
                    _addPostSysService.rebuildTagField.value
                        ? tagWidget = TagsTextFieldComponent(
                            listTags: _addPostSysService.post.value.tags,
                          )
                        : tagWidget = const SizedBox.shrink();

                    return tagWidget;
                  }),
                  const SizedBox(height: 22),
                  sectionBuilder()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavBar(saveDraft, updatePostStream));
  }
}
