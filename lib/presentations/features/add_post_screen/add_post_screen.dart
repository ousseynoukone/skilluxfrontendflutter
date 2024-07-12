import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/tags_text_field.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_field.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var _stringTagController = StringTagController();



    @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    final TextEditingController _titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(text.createPublication),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                addMediaWidget(text.addCoverPhoto, () {}),
                const SizedBox(height: 22),
                TextFieldComponent(
                  controller: _titleController,
                  labelText: text.title,
                ),
                const SizedBox(height: 22),
                TagsTextFieldComponent(stringTagController: _stringTagController,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
