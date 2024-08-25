import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loader/linear_loader.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PersistentHeader extends StatefulWidget {
  const PersistentHeader({super.key});

  @override
  State<PersistentHeader> createState() => _PersistentHeaderState();
}

class _PersistentHeaderState extends State<PersistentHeader> {
  final UserProfilePostService userProfilePostService = Get.find();

  @override
  Widget build(BuildContext context) {
    final text = context.localizations;
    final TextTheme textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    getlinearProgressingIndicator({bool inverseOrentiation = false}) {
      return Obx(() => userProfilePostService.isLoading.value
          ? linearProgressingIndicator(inverseOrentiation: inverseOrentiation)
          : const SizedBox.shrink());
    }

    return Container(
      decoration: BoxDecoration(
          color: colorScheme.tertiary,
          border: BorderDirectional(
              bottom: BorderSide(color: colorScheme.onPrimary, width: 0.3),
              top: BorderSide(color: colorScheme.onPrimary, width: 0.3))),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getlinearProgressingIndicator(),
          const Icon(
            Icons.library_books,
          ),
          Text(
            text.publication,
            style: textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
          getlinearProgressingIndicator(inverseOrentiation: true)
        ],
      ),
    );
  }
}
