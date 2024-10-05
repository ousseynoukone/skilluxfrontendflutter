import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagsTextFieldComponent extends StatelessWidget {
  final List<String> initialTags;
  final FocusNode focusNode;

  const TagsTextFieldComponent({
    super.key,
    required this.initialTags,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;
    final text = context.localizations;
    final addPostSysService = Get.find<AddPostSysService>();
    final stringTagController = StringTagController();

    return TextFieldTags<String>(
      focusNode: focusNode,
      textfieldTagsController: stringTagController,
      initialTags: initialTags,
      textSeparators: const [' ', ','],
      inputFieldBuilder: (context, inputFieldValues) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text.tags,
              style: themeText.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            TextField(
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
              decoration: _buildInputDecoration(
                  context,
                  inputFieldValues,
                  text,
                  themeText,
                  colorScheme,
                  stringTagController,
                  addPostSysService),
              onChanged: (value) =>
                  _handleTagChange(value, inputFieldValues, addPostSysService),
              onSubmitted: (value) =>
                  _handleTagSubmit(value, inputFieldValues, addPostSysService),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context,
      InputFieldValues<String> inputFieldValues,
      dynamic text,
      TextTheme themeText,
      ColorScheme colorScheme,
      StringTagController stringTagController,
      AddPostSysService addPostSysService) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle:
          themeText.titleMedium?.copyWith(color: colorScheme.onSecondary),
      floatingLabelStyle:
          themeText.titleMedium?.copyWith(color: colorScheme.onSecondary),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsTheme.secondary, width: 2)),
      hintStyle: themeText.bodySmall,
      hintText: inputFieldValues.tags.isNotEmpty ? '' : text.addTags,
      suffixIcon: IconButton(
        onPressed: () => _clearTags(
            stringTagController, addPostSysService, inputFieldValues),
        icon: const Icon(Icons.close),
      ),
      prefixIconConstraints: BoxConstraints(maxWidth: Get.width * 0.75),
      prefixIcon: _buildTagList(inputFieldValues),
    );
  }

  Widget? _buildTagList(InputFieldValues<String> inputFieldValues) {
    if (inputFieldValues.tags.isEmpty) return null;

    return SingleChildScrollView(
      controller: inputFieldValues.tagScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: inputFieldValues.tags
            .map((String tag) => _buildTagChip(tag, inputFieldValues))
            .toList(),
      ),
    );
  }

  Widget _buildTagChip(String tag, InputFieldValues<String> inputFieldValues) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: ColorsTheme.primary,
      ),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('#$tag', style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 4.0),
          InkWell(
            child: const Icon(Icons.cancel,
                size: 14.0, color: Color.fromARGB(255, 233, 233, 233)),
            onTap: () => _removeTag(tag, inputFieldValues),
          )
        ],
      ),
    );
  }

  void _clearTags(
      StringTagController stringTagController,
      AddPostSysService addPostSysService,
      InputFieldValues<String> inputFieldValues) {
    stringTagController.clearTags();
    addPostSysService.clearTag();
    inputFieldValues.tags = [];
  }

  void _removeTag(String tag, InputFieldValues<String> inputFieldValues) {
    inputFieldValues.onTagRemoved(tag);
    Get.find<AddPostSysService>().setTags(inputFieldValues.tags);
  }

  void _handleTagChange(String value, InputFieldValues<String> inputFieldValues,
      AddPostSysService addPostSysService) {
    inputFieldValues.onTagChanged(value);
    addPostSysService.setTags(inputFieldValues.tags);
  }

  void _handleTagSubmit(String value, InputFieldValues<String> inputFieldValues,
      AddPostSysService addPostSysService) {
    inputFieldValues.onTagSubmitted(value);
    addPostSysService.setTags(inputFieldValues.tags);
  }
}
