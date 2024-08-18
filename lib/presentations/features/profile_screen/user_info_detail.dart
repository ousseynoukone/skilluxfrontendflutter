import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_tags.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/post_container.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/user_info.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoDetail extends StatelessWidget {
  const UserInfoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of UserProfileService
    final UserProfileService userProfileService = Get.find();
    final AppLocalizations text = context.localizations;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Logger _logger = Logger();
    var colorScheme = Theme.of(context).colorScheme;

    return userProfileService.obx(
      (state) => UserInfo(
        userInfoDto: state!,
        isForOtherUser: false,
      ),

      // here you can put your custom loading indicator, but
      // by default would be Center(child:CircularProgressIndicator())
      onLoading: Center(
          child: CircularProgressIndicator(color: colorScheme.onPrimary)),
      // onEmpty: const Text('No data found'),

      // here also you can set your own error widget, but by
      // default will be an Center(child:Text(error))
      onError: (error) => Text(error!),
    );
  }
}
