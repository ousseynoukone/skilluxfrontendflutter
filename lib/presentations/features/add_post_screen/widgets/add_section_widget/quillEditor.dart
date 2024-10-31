import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/helper/helper.dart';

class Quilleditor extends StatelessWidget {
  final QuillController controller;
  final bool displayMode;
  final bool expanded;
  final bool scrollable;
  final Color? bgColor;
  final bool displayToolsBar;

  const Quilleditor({
    super.key,
    required this.controller,
    this.displayToolsBar = false,
    this.bgColor,
    this.displayMode = false,
    this.scrollable = true,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = context.localizations;

    return scrollable
        ? _buildScrollableEditor(context, colorScheme, text)
        : _buildNonScrollableEditor(colorScheme, context);
  }

  Widget _buildScrollableEditor(
      BuildContext context, ColorScheme colorScheme, dynamic text) {
    return Column(
      children: [
        if (!displayMode) _buildToolbar(),
        Expanded(child: _buildEditor(context, colorScheme, text)),
      ],
    );
  }

  Widget _buildNonScrollableEditor(
      ColorScheme colorScheme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor ?? colorScheme.primaryContainer,
      ),
      child: QuillEditor.basic(
        configurations: _getEditorConfigurations(
            scrollable: false,
            expands: false,
            showCursor: false,
            context: context),
      ),
    );
  }

  Widget _buildToolbar() {
    return displayToolsBar
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: QuillToolbar.simple(
              configurations: getQuillSimpleToolbarConfigurations(controller),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildEditor(
      BuildContext context, ColorScheme colorScheme, dynamic text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.primaryContainer,
      ),
      child: QuillEditor.basic(
        configurations: _getEditorConfigurations(
          context: context,
          scrollable: scrollable,
          expands: expanded,
          showCursor: !displayMode,
          placeholder: text.quillEditorPlaceholder,
        ),
      ),
    );
  }

  QuillEditorConfigurations _getEditorConfigurations(
      {required bool scrollable,
      required bool expands,
      required bool showCursor,
      String? placeholder,
      required BuildContext context}) {
    var embedBuilders = kIsWeb
        ? FlutterQuillEmbeds.editorWebBuilders()
        : FlutterQuillEmbeds.editorBuilders();

    return QuillEditorConfigurations(
        embedBuilders: embedBuilders,
        controller: controller,
        autoFocus: false,
        expands: expands,
        scrollable: scrollable,
        showCursor: showCursor,
        placeholder: placeholder,
        customStyles: getDefaultStyles(),
        textSelectionThemeData: Theme.of(context)
            .textSelectionTheme
            .copyWith(selectionColor: ColorsTheme.secondary.withOpacity(0.3)));
  }
}
