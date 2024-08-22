import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loader/linear_loader.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final text = context.localizations;
    final TextTheme textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    final progress = shrinkOffset / maxExtent;

    final UserProfilePostService userProfilePostService = Get.find();

    getlinearProgressingIndicator({bool inverseOrentiation = false}) {
      return Obx(() => userProfilePostService.isLoading.value
          ? linearProgressingIndicator(inverseOrentiation: inverseOrentiation)
          : const SizedBox.shrink());
    }

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: 1,
              child: Container(
                color: colorScheme.secondary,
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
                    getlinearProgressingIndicator(inverseOrentiation: true),
                  ],
                ),
              )),
          AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: 1 - progress,
              child: Container(
                decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    border: BorderDirectional(
                        bottom: BorderSide(
                            color: colorScheme.onPrimary, width: 0.3),
                        top: BorderSide(
                            color: colorScheme.onPrimary, width: 0.3))),
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
              )),

        ],
      ),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
