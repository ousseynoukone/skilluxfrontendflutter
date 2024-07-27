import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagsTextFieldComponent extends StatefulWidget {
  final List<String> listTags;

  TagsTextFieldComponent({required this.listTags});

  @override
  _TagsTextFieldComponentState createState() => _TagsTextFieldComponentState();
}

class _TagsTextFieldComponentState extends State<TagsTextFieldComponent> {
  late BuildContext context;
  late double distanceToField;
  final AddPostSysService _addPostSysService = Get.find();
  late StringTagController _stringTagController;
  @override
  void initState() {
    super.initState();
    context = Get.context!;
    distanceToField = Get.width;
    _stringTagController = StringTagController();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;
    final text = context.localizations;

    return TextFieldTags<String>(
      textfieldTagsController: _stringTagController,
      initialTags: widget.listTags,
      textSeparators: const [' ', ','],
      inputFieldBuilder: (context, inputFieldValues) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text.tags,
              style: themeText.bodyMedium?.copyWith(
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            TextField(
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: themeText.titleMedium
                    ?.copyWith(color: colorScheme.onSecondary),
                floatingLabelStyle: themeText.titleMedium
                    ?.copyWith(color: colorScheme.onSecondary),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.onSurface),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorsTheme.secondary, width: 2),
                ),
                hintStyle: themeText.bodySmall,
                hintText: inputFieldValues.tags.isNotEmpty ? '' : text.addTags,
                suffixIcon: IconButton(
                  onPressed: () {
                    _stringTagController.clearTags();
                    _addPostSysService.clearTag();
                    inputFieldValues.tags = [];

                    print(
                        "stringTagController  ${_stringTagController.getTags}");
                    print(
                        "_addPostSysService  ${_addPostSysService.post.value.tags}");
                    print("inputFieldValues  ${inputFieldValues.tags}");
                  },
                  icon: const Icon(Icons.close),
                ),
                prefixIconConstraints:
                    BoxConstraints(maxWidth: distanceToField * 0.75),
                prefixIcon: inputFieldValues.tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: inputFieldValues.tagScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: inputFieldValues.tags.map((String tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: ColorsTheme.primary,
                              ),
                              margin: const EdgeInsets.only(right: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '#$tag',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      //print("$tag selected");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      inputFieldValues.onTagRemoved(tag);
                                      _addPostSysService
                                          .setTags(inputFieldValues.tags);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : null,
              ),
              onChanged: (value) {
                inputFieldValues.onTagChanged(value);
                // UPDATE POST TAGS EACH TIME THERE IS A CHANGE
                _addPostSysService.setTags(inputFieldValues.tags);
              },
              onSubmitted: inputFieldValues.onTagSubmitted,
            ),
          ],
        );
      },
    );
  }
}
