import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_embeds.dart';
import 'package:flutter_quill_extensions/models/config/image/toolbar/image_configurations.dart';
import 'package:flutter_quill_extensions/models/config/video/toolbar/video_configurations.dart';
import 'package:get/get.dart';

QuillSimpleToolbarConfigurations getQuillSimpleToolbarConfigurations(
    QuillController controller,
    {bool isRounded = true}) {
  var colorScheme = Theme.of(Get.context!).colorScheme;

  // Custom function to dismiss keyboard and handle image picking
  Future<void> onImageButtonPressed(BuildContext context) async {
    // Dismiss the keyboard
    FocusScope.of(context).unfocus();

    // Simulate picking an image URL
    String? imageUrl = await pickImage(); // Replace with actual image picker
    if (imageUrl == null) {
      // Show a snackbar if image selection is canceled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selection canceled')),
      );
    }
    // Handle the image URL (you would typically use `controller.insertImage` here if needed)
  }

  return QuillSimpleToolbarConfigurations(
    toolbarSectionSpacing: BorderSide.strokeAlignCenter,
    controller: controller,
    showHeaderStyle: false,
    showBoldButton: true,
    showItalicButton: true,
    showUnderLineButton: true, // Removed
    showStrikeThrough: false, // Remove
    showColorButton: false, // Removed
    showBackgroundColorButton: false,
    showClearFormat: true, // Removed
    showAlignmentButtons: true, // Removed
    showLeftAlignment: true,
    showCenterAlignment: true,
    showRightAlignment: true,
    showListNumbers: true,
    showListBullets: true,
    showListCheck: false,
    showCodeBlock: true,
    showQuote: true,
    showLink: true,
    showUndo: false, // Removed
    showRedo: false, // Removed
    showClipboardCut: false,
    showClipboardCopy: false,
    showClipboardPaste: false,
    showFontFamily: false,
    showFontSize: false,
    showSearchButton: false,
    showIndent: false, // Removed
    multiRowsDisplay: false, // Added to make toolbar single-row
    embedButtons: FlutterQuillEmbeds.toolbarButtons(
      videoButtonOptions:
          null, // Set videoButtonOptions to null to disable video
      imageButtonOptions: QuillToolbarImageButtonOptions(
        afterButtonPressed: () => onImageButtonPressed(Get.context!),
      ),
    ),
    decoration: BoxDecoration(
      color: colorScheme.primaryContainer,
      borderRadius: isRounded ? BorderRadius.circular(12) : null,
    ),
  );
}

// Dummy image picker function for testing
Future<String?> pickImage() async {
  // Replace this with actual image selection logic
  return 'https://example.com/your_image.png';
}

DefaultStyles getDefaultStyles() {
  var textTheme = Theme.of(Get.context!).textTheme;

  return DefaultStyles(
    h1: DefaultListBlockStyle(textTheme.titleLarge!,
        const VerticalSpacing(8, 0), const VerticalSpacing(0, 0), null, null),
    h2: DefaultListBlockStyle(textTheme.titleMedium!,
        const VerticalSpacing(8, 0), const VerticalSpacing(0, 0), null, null),
    h3: DefaultListBlockStyle(textTheme.titleSmall!,
        const VerticalSpacing(8, 0), const VerticalSpacing(0, 0), null, null),
    placeHolder: DefaultListBlockStyle(textTheme.bodySmall!,
        const VerticalSpacing(0, 0), const VerticalSpacing(0, 0), null, null),
    paragraph: DefaultListBlockStyle(textTheme.bodyMedium!,
        const VerticalSpacing(0, 0), const VerticalSpacing(0, 0), null, null),
  );
}
