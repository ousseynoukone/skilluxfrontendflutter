import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/content_converter.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/image_handling.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/helper/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/quillEditor.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

class AddSection extends StatefulWidget {
  final bool editMode;

  const AddSection({super.key, this.editMode = false});

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> with ImagePickerMixin {
  final Logger _logger = Logger();
  final QuillController _controller = QuillController.basic();
  final AddPostSysService _addPostSysService = Get.find();
  bool isKeyboardVisible = false;
  final FocusNode _editorFocusNode =
      FocusNode(); // <-- Define the FocusNode here

  @override
  void initState() {
    super.initState();

    if (widget.editMode) {
      _controller.document = Document.fromJson(
          jsonDecode(_addPostSysService.post.value.content.content!));
    }
  }

  @override
  void dispose() {
    _editorFocusNode.dispose();
    super.dispose();
  }

  addSection() {
    var text = Get.context!.localizations;

    if (!_controller.document.isEmpty()) {
      String jsonString =
          DocumentConverter.convertToJsonString(_controller.document) ?? "";
      _addPostSysService.post.value.content.content = jsonString;
      Get.back();
    } else {
      showCustomSnackbar(
          title: text.alert,
          message: text.mendatoryContent,
          snackType: SnackType.warning,
          duration: const Duration(seconds: 7));
    }
  }

  Widget _buildToolbar() {
    return QuillToolbar.simple(
      configurations:
          getQuillSimpleToolbarConfigurations(_controller, isRounded: false),
    );
  }

  buildBody() {
    if (Platform.isAndroid || Platform.isIOS) {
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Quilleditor(
                displayToolsBar: false,
                controller: _controller,
                displayMode: false,
              ),
            ),
          ),
          isKeyboardVisible ? _buildToolbar() : const SizedBox.shrink()
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Quilleditor(
          displayToolsBar: true,
          controller: _controller,
          scrollable: false,
          displayMode: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    isKeyboardVisible = keyboardHeight > 0; // Update keyboard visibility

    // if (isKeyboardVisible) {
    //   _logger.d("called");
    //   _editorFocusNode.requestFocus(); // <-- Request focus here
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text(text.addSection),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              height: 50,
              child: OutlineButtonComponent(
                edgeInsets: const EdgeInsets.all(8.0),
                icon: Icons.save,
                text: text.save,
                onPressed: () async {
                  if (!_controller.document.isEmpty()) {
                    String jsonString = DocumentConverter.convertToJsonString(
                            _controller.document) ??
                        "";
                    _addPostSysService.post.value.content.content = jsonString;
                    Get.back();
                  } else {
                    showCustomSnackbar(
                        title: text.alert,
                        message: text.mendatoryContent,
                        snackType: SnackType.warning,
                        duration: const Duration(seconds: 7));
                  }
                },
                isLoading: false,
              ),
            )
          ],
        ),
        body: buildBody());
  }
}
