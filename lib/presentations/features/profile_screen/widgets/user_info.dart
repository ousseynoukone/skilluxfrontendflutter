import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/user_followers/user_followers.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/user_followings/user_following.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/user_info_update/update_user_info.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/user_infos_sub_widgets/user_info_user_pp.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loader/linear_loader.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class UserInfo extends StatefulWidget {
  final User user;
  final bool isForOtherUser;
  final int userId;

  const UserInfo({
    super.key,
    required this.user,
    this.isForOtherUser = false,
    this.userId = 0,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final Logger _logger = Logger();
  late UserProfileService _userProfileService;

  @override
  void initState() {
    super.initState();
    _userProfileService = Get.find<UserProfileService>();
    // Initialize follow status
    _userProfileService.updateFollowStatus(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;
    final AppLocalizations text = context.localizations;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(user),
          _buildUserStats(user, text, colorScheme),
        ],
      ),
    );
  }

  Widget _buildUserHeader(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserInfoUserProfilePicture(
          profilePictureUrl: user.profilePicture,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn(
              count: user.nbFollowers,
              label: context.localizations.follower,
              onTap: () {
                if (user.nbFollowers > 0) {
                  Get.to(() => UserFollowers(userId: widget.userId));
                }
              },
            ),
            SizedBox(
              width: Get.width * 0.015,
            ),
            _buildStatColumn(
              count: user.nbFollowings,
              label: context.localizations.following,
              onTap: () {
                if (user.nbFollowings > 0) {
                  Get.to(() => UserFollowing(userId: widget.userId));
                }
              },
            ),
            SizedBox(
              width: Get.width * 0.015,
            ),
            _buildStatColumn(
              count: user.nbPosts,
              label: context.localizations.publication,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserStats(
      User user, AppLocalizations text, ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.fullName, style: Theme.of(context).textTheme.titleSmall),
        Container(
          decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: Text('@${user.username}',
              style: Theme.of(context).textTheme.bodySmall!),
        ),
        if (user.profession != null)
          Text(user.profession!, style: Theme.of(context).textTheme.bodySmall),
        _buildFollowUnfollowButton(user, text),
        _buildEditProfileButton(text, colorScheme),
      ],
    );
  }

  Widget _buildStatColumn({
    required int count,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Text(count.toString()),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildFollowUnfollowButton(User user, AppLocalizations text) {
    return widget.isForOtherUser
        ? Obx(() {
            if (_userProfileService.isLoading.value) {
              return const SizedBox(
                width: 100,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: LinearProgressIndicator()),
                ),
              );
            }
            return _userProfileService.isFollowing.value
                ? _buildUnfollowButton(text)
                : _buildFollowButton(text);
          })
        : const SizedBox.shrink();
  }

  Widget _buildFollowButton(AppLocalizations text) {
    return OutlineButtonComponent(
      onPressed: () {
        _userProfileService.follow(widget.userId);
        _updateFollowerCount(true);
      },
      text: text.follow,
      isLoading: _userProfileService.isLoading.value,
      icon: Icons.notifications,
    );
  }

  Widget _buildUnfollowButton(AppLocalizations text) {
    return OutlineButtonComponent(
      onPressed: () {
        _userProfileService.unfollow(widget.userId);
        _updateFollowerCount(false);
      },
      text: text.unfollow,
      isLoading: _userProfileService.isLoading.value,
      icon: Icons.notifications_none,
    );
  }

  void _updateFollowerCount(bool increment) {
    setState(() {
      if (increment) {
        widget.user.nbFollowers += 1;
      } else {
        widget.user.nbFollowers -= 1;
      }
    });
  }

  Widget _buildEditProfileButton(
      AppLocalizations text, ColorScheme colorScheme) {
    return !widget.isForOtherUser
        ? SizedBox(
            child: OutlineButtonComponent(
              onPressed: () {
                Get.bottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        // Bottom corners are square (0 radius)
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    backgroundColor: colorScheme.primary,
                    UpdateUserInfoScreen(user: widget.user));
              },
              text: text.editProfile,
              isLoading: false,
              icon: Icons.edit,
              edgeInsets:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
          )
        : const SizedBox.shrink();
  }
}
