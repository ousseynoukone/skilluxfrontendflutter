import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/image_handling.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_update_service.dart';

class UserInfoUserProfilePicture extends StatefulWidget {
  final String? profilePictureUrl;

  const UserInfoUserProfilePicture({
    super.key,
    required this.profilePictureUrl,
  });

  @override
  _UserInfoUserProfilePictureState createState() =>
      _UserInfoUserProfilePictureState();
}

class _UserInfoUserProfilePictureState extends State<UserInfoUserProfilePicture>
    with ImagePickerMixin {
  final UserUpdateService _userUpdateService = Get.put(UserUpdateService());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final text = context.localizations;

    handlingPickedImage() {
      Get.bottomSheet(
          backgroundColor: colorScheme.primary,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              displayPickedImage(),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => OutlineButtonComponent(
                    text: text.update,
                    onPressed: () async {
                     await  _userUpdateService.updateUserPP(pickedImage!);
                     
                    },
                    isLoading: _userUpdateService.isLoading.value),
              )
            ],
          ));
    }

    return Stack(
      children: [
        // Profile Picture
        displayUserPP(widget.profilePictureUrl, radius: 60),

        // Tappable Icon
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: ColorsTheme.secondary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: () async {
                await pickImage();
                handlingPickedImage();
              },
            ),
          ),
        ),
      ],
    );
  }
}
