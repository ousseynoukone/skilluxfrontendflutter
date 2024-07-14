import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/text_area.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_field.dart';

class AddSection extends StatefulWidget {
  const AddSection({super.key});

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    final TextEditingController _titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(text.createSection),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFieldComponent(
                controller: _titleController,
                labelText: text.title,
                hintText: text.optionalField,
              ),
              const SizedBox(height: 22),
              addMediaWidget(text.addMedia, () {}, heightFactor: 12),
              const SizedBox(height: 11),
              const Divider(),
              const TextArea()
            ],
          ),
        ),
      ),
    );
  }
}
