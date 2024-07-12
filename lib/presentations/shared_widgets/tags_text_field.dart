import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_field.dart';

class TagsTextFieldComponent extends StatefulWidget {
  final StringTagController stringTagController;
  const TagsTextFieldComponent({super.key, required this.stringTagController});

  @override
  State<TagsTextFieldComponent> createState() => _TagsTextFieldComponentState();
}

class _TagsTextFieldComponentState extends State<TagsTextFieldComponent> {
  final List<String> _tags = [];
  late double _distanceToField;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = Get.width;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var themeText = context.textTheme;
    var text = context.localizations;

    return Column(
      children: [
        TextFieldTags<String>(
          textfieldTagsController: widget.stringTagController,
          initialTags: _tags,
          textSeparators: const [' ', ','],
          // validator: (String tag) {
          //   if (tag == 'php') {
          //     return 'Php not allowed';
          //   }
          //   return null;
          // },
          inputFieldBuilder: (context, inputFieldValues) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.tags,
                    style: themeText.bodyMedium?.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w700),
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
                      hintText:
                          inputFieldValues.tags.isNotEmpty ? '' : text.addTags,
                      suffixIcon: IconButton(
                          onPressed: () {
                            widget.stringTagController.clearTags();
                          },
                          icon: Icon(Icons.close)),
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.75),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children:
                                      inputFieldValues.tags.map((String tag) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: ColorsTheme.primary,
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          '#$tag',
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                          color: Color.fromARGB(
                                              255, 233, 233, 233),
                                        ),
                                        onTap: () {
                                          inputFieldValues.onTagRemoved(tag);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: inputFieldValues.onTagChanged,
                    onSubmitted: inputFieldValues.onTagSubmitted,
                  ),
                ]);
          },
        ),
      ],
    );
  }
}
