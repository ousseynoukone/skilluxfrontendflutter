import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/post_title_validator.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/content/content.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/helper.dart';

class AddPostSysService extends GetxController {
  // Initialize with an empty Post object
  Rx<Post> post = Rx<Post>(
      Post(id: null, tags: [], title: '', content: Content(content: '')));
  RxInt isFromDraft = 0.obs;
  RxInt clearPostField = 0.obs;
  var rebuildTagField = true.obs;
  final isLoading = false.obs;

  final Logger _logger = Logger();
  List<String> _previousTag = [];

  void addPost(Post newPost) {
    post.value = newPost;
    _previousTag = [];
  }

  clearContent() {
    post.value = Post(
      tags: post.value.tags,
      title: post.value.title,
      content: Content(content: ''),
    );
  }

  // Function to add a tag and trigger the rebuild notifier
  void setTags(List<String> newTags) {
    // Check if the new tags list is different from the current one
    if (!areListsEqual(post.value.tags, newTags)) {
      post.value = Post(
        id: post.value.id,
        tags: newTags,
        title: post.value.title,
        content: post.value.content,
      );
      _previousTag = newTags;
    }
  }

  // Function to set id and trigger the rebuild notifier
  void setId(int id) {
    // Check if the new tags list is different from the current one
    post.value = Post(
      id: id,
      tags: post.value.tags,
      title: post.value.title,
      content: post.value.content,
    );
  }

// THIS FUNCTION IS FOR TAG FIELD , IT HELP IT TO REBUILD AFTER A NEW POST HAS BEEN SELECTED FROM DRAFT IN ORDER TO DISPLAY IT'S TAG TROUGHT THE INITIAL TAGS PARAMETER WHICH IS ONLY CALLED ONCE SO I NEED TO RE-INSTANCIATE THE TAG INPUT IN ORDER TO PROGRAMMATICALLY DISPLAY TAG (controller.addTag(tag) do not work)
  rebuildTagFieldToDisplayTags({bool isForClear = false}) {
    //Is for clear is crutial , when we try to clear post , it would  try to check this condition !areListsEqual(post.value.tags, _previousTag which would not success because we are not trying to add and bring changes but just to clear , so we have to bypass that condition
    if (isForClear) {
      rebuildTagField.value = false;
      //WAITING THE NEXT FRAME FOR CHANGEMENT TO BE APPLIED
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Now we can safely rebuild and set the value to true;
        rebuildTagField.value = true;
      });
    } else if (!areListsEqual(post.value.tags, _previousTag)) {
      rebuildTagField.value = false;
      //WAITING THE NEXT FRAME FOR CHANGEMENT TO BE APPLIED
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Now we can safely rebuild and set the value to true;
        rebuildTagField.value = true;
      });
    }
  }

  bool isPostNotEmpty({
    bool showError = false,
    bool checkTitle = true,
    bool checkTags = true,
    bool checkContent = true,
    bool checkHeaderImage = true,
  }) {
    var text = Get.context!.localizations;

    bool result = true;

    if (checkTitle) {
      result = result &&
          post.value.title.isNotEmpty &&
          PostTitleValidator.validate(post.value.title) == null;
    }

    if (checkTags) {
      result = result && post.value.tags.isNotEmpty;
    }

    if (checkContent) {
      result = result && post.value.content.content!.isNotEmpty;
    }

    // if (checkHeaderImage) {
    //   result = result && post.value.headerImageIMG != null;
    // }

    if (!result && showError) {
      showCustomSnackbar(
        title: text.alert,
        message: text.nothingToShow,
        snackType: SnackType.warning,
      );
    }

    return result;
  }

  isContentEmpty() {
    return post.value.content.content!.isNotEmpty;
  }

  void clearTag() {
    // Reset to a new empty Post object instead of null
    post.value = Post(
      id: post.value.id,
      title: post.value.title,
      content: post.value.content,
      tags: [],
    );
  }

  void clearPost() {
    // Reset to a new empty Post object instead of null
    post.value = Post(
      id: null,
      title: '',
      content: Content(content: ''),
      tags: [],
    );
    _previousTag = [];

    clearPostField.value++;
  }
}
