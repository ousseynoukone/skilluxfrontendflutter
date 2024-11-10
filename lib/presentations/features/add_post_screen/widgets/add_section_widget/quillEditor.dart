import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/helper/helper.dart';

class Quilleditor extends StatefulWidget {
  final QuillController controller;
  final bool displayMode;
  final bool expanded;
  final bool scrollable;
  final Color? bgColor;
  final bool displayToolsBar;
  final FocusNode? focusNode;

  const Quilleditor({
    super.key,
    required this.controller,
    this.displayToolsBar = false,
    this.bgColor,
    this.displayMode = false,
    this.scrollable = true,
    this.expanded = true,
    this.focusNode,
  });

  @override
  _QuilleditorState createState() => _QuilleditorState();
}

class _QuilleditorState extends State<Quilleditor> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Use the passed FocusNode or create a new one if none is provided
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose(); // Dispose only if we created it
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = context.localizations;

    return widget.scrollable
        ? _buildScrollableEditor(context, colorScheme, text)
        : _buildNonScrollableEditor(colorScheme, context);
  }

  Widget _buildScrollableEditor(
      BuildContext context, ColorScheme colorScheme, dynamic text) {
    return Column(
      children: [
        if (!widget.displayMode) _buildToolbar(),
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
        color: widget.bgColor ?? colorScheme.primaryContainer,
      ),
      child: QuillEditor.basic(
        focusNode: _focusNode,
        configurations: _getEditorConfigurations(
          colorScheme: colorScheme,
          context: context,
          scrollable: false,
          expands: false,
          showCursor: false,
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return widget.displayToolsBar
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: QuillToolbar.simple(
              configurations:
                  getQuillSimpleToolbarConfigurations(widget.controller),
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
        focusNode: _focusNode,
        configurations: _getEditorConfigurations(
            colorScheme: colorScheme,
            context: context,
            scrollable: widget.scrollable,
            expands: widget.expanded,
            showCursor: !widget.displayMode,
            placeholder: text.quillEditorPlaceholder),
      ),
    );
  }

  QuillEditorConfigurations _getEditorConfigurations({
    required bool scrollable,
    required bool expands,
    required bool showCursor,
    required ColorScheme colorScheme,
    String? placeholder,
    required BuildContext context,
  }) {
    var embedBuilders = kIsWeb
        ? FlutterQuillEmbeds.editorWebBuilders()
        : FlutterQuillEmbeds.editorBuilders();

    return QuillEditorConfigurations(
      embedBuilders: embedBuilders,
      controller: widget.controller,
      autoFocus: !widget.displayMode,
      expands: expands,
      scrollable: scrollable,
      showCursor: showCursor,
      placeholder: placeholder,
      customStyles: getDefaultStyles(),
    );
  }
}
