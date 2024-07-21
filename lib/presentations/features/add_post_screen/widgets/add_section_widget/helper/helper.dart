import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_embeds.dart';
import 'package:get/get.dart';

QuillSimpleToolbarConfigurations getQuillSimpleToolbarConfigurations(
    QuillController controller) {
  var colorScheme = Theme.of(Get.context!).colorScheme;
  return QuillSimpleToolbarConfigurations(
      toolbarSectionSpacing: BorderSide.strokeAlignCenter,
      controller: controller,
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
      embedButtons: FlutterQuillEmbeds.toolbarButtons(),
      decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12)));
}

DefaultStyles getDefaultStyles() {
  var textTheme = Theme.of(Get.context!).textTheme;

  return DefaultStyles(
      h1: DefaultListBlockStyle(textTheme.titleLarge!,
          const VerticalSpacing(8, 0), const VerticalSpacing(0, 0), null, null),
      h2: DefaultListBlockStyle(textTheme.titleMedium!,
          const VerticalSpacing(8, 0), const VerticalSpacing(0, 0), null, null),
      h3: DefaultListBlockStyle(
          textTheme.titleSmall!,
          const VerticalSpacing(8, 0),
          const VerticalSpacing(0, 0),
          null,
          null));
}
