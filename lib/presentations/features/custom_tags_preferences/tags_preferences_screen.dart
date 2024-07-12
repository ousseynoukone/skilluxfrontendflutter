import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/models/tag/tag.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_tags_preference_controller.dart';

class TagsPreferencesScreen extends StatefulWidget {
  const TagsPreferencesScreen({super.key});

  @override
  State<TagsPreferencesScreen> createState() => _TagsPreferencesScreenState();
}

class _TagsPreferencesScreenState extends State<TagsPreferencesScreen> {
  GetXUserTagsPreference getXUserTagsPreferenceController =
      Get.put(GetXUserTagsPreference());

  List<Tag> tags = [];
  List<int> selectedTagIds = [];

  @override
  void initState() {
    getXUserTagsPreferenceController.getTagsPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    var text = context.localizations;
    return Scaffold(
        body: getXUserTagsPreferenceController.obx(
      (state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: ListTile(
                title: Text(text.personalizeYourFeed,
                    style: textTheme.headlineSmall),
                leading: const Icon(
                  Icons.verified_user,
                ),
                subtitle:
                    Text(text.personalizeMessage, style: textTheme.bodySmall),
              ),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            ChipsChoice<int>.multiple(
              choiceStyle: C2ChipStyle.filled(
                color: colorScheme.onPrimary,
                selectedStyle: C2ChipStyle(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    backgroundColor: colorScheme.onSurface),
              ),
              wrapped: true,
              value: selectedTagIds,
              choiceCheckmark: true,
              onChanged: (val) => setState(() => selectedTagIds = val),
              choiceItems: C2Choice.listFrom<int, Tag>(
                source: state!,
                value: (i, tag) => tag.id,
                label: (i, tag) => tag.libelle ?? '',
              ),
            ),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(vertical: 28.0),
                  width: Get.width / 2.5,
                  alignment: Alignment.center,
                  child: OutlineButtonComponent(
                      text: text.ok,
                      onPressed: () => {
                            if (selectedTagIds.isNotEmpty)
                              {
                                getXUserTagsPreferenceController
                                    .setUsersPreferences(selectedTagIds)
                              }
                          },
                      isLoading:
                          getXUserTagsPreferenceController.isLoading.value),
                ))
          ]),
      onLoading: const Center(
        child: CircularProgressIndicator(
          color: ColorsTheme.primary,
        ),
      ),
      onEmpty: Center(child: Text(text.errorUnexpected)),
      onError: (error) => Text(error ?? text.errorUnexpected),
    ));
  }
}
