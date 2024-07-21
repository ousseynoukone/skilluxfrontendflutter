import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/image_handling.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/quillEditor.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_field.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';

class AddSection extends StatefulWidget {
  final bool editMode;

  const AddSection({super.key,  this.editMode = false});

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> with ImagePickerMixin {
  final Logger _logger = Logger();
  final TextEditingController _titleController = TextEditingController();
  final QuillController _controller = QuillController.basic();
  AddSectionSysService addSectionSysService = Get.find();

  @override
  void initState() {
    super.initState();

    if (widget.editMode) {
      _controller.document =
          Document.fromJson(jsonDecode(addSectionSysService.content.value));
        
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(text.createSection),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Quilleditor(
            controller: _controller,
            displayMode: false,
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: IconTextButton(
                icon: Icons.save,
                label: text.save,
                onPressed: () async {
                  if (!_controller.document.isEmpty()) {
                    String jsonString =
                        jsonEncode(_controller.document.toDelta().toJson());

                    addSectionSysService.content.value = jsonString;
                    Get.back();
                  } else {
                    showCustomSnackbar(
                        title: text.alert,
                        message: text.mendatoryContent,
                        snackType: SnackType.warning,
                        duration: const Duration(seconds: 7));
                  }
                },
              ),
            ),
          ),
        ));
  }
}
