import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';

class SwitchFeedMod extends StatefulWidget {
  const SwitchFeedMod({super.key});

  @override
  State<SwitchFeedMod> createState() => _SwitchFeedModState();
}

class _SwitchFeedModState extends State<SwitchFeedMod> {
  FeedType dropdownValue = FeedType.recommendedPosts;
  PostFeedController recommendedFeedController = Get.find();

  @override
  Widget build(BuildContext context) {
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var text = context.localizations;

    return DropdownButton<FeedType>(
      value: dropdownValue,
      elevation: 16,
      dropdownColor: colorScheme.tertiary,
      style: themeText.bodySmall,
      underline: Container(
        height: 2,
        color: colorScheme.primary,
      ),
      onChanged: (FeedType? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          recommendedFeedController.switchFeedMod(dropdownValue);
        });
      },
      items: FeedType.values.map<DropdownMenuItem<FeedType>>((FeedType value) {
        return DropdownMenuItem<FeedType>(
          value: value,
          child: Text(
            getFeedTypeDisplayName(value, text),
            style: themeText.bodySmall,
          ),
        );
      }).toList(),
    );
  }

}
