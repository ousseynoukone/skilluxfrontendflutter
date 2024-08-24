import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/user_followers/user_followers.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/user_followings/user_following.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/loader/linear_loader.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class UserInfo extends StatefulWidget {
  final User userInfoDto;
  final bool isForOtherUser;
  final int userId;

  const UserInfo({
    super.key,
    required this.userInfoDto,
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
    final User user = widget.userInfoDto;
    final AppLocalizations text = context.localizations;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(user),
          _buildUserStats(user, text),
        ],
      ),
    );
  }

  Widget _buildUserHeader(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profilePicture!),
          radius: 60,
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
            _buildStatColumn(
              count: user.nbFollowings,
              label: context.localizations.following,
              onTap: () {
                if (user.nbFollowings > 0) {
                  Get.to(() => UserFollowing(userId: widget.userId));
                }
              },
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

  Widget _buildUserStats(User user, AppLocalizations text) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(user.fullName ?? '',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 5),
        if (user.profession != null)
          Text(user.profession!, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 10),
        _buildFollowUnfollowButton(user, text),
        _buildEditProfileButton(text),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(count.toString()),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
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
        widget.userInfoDto.nbFollowers += 1;
      } else {
        widget.userInfoDto.nbFollowers -= 1;
      }
    });
  }

  Widget _buildEditProfileButton(AppLocalizations text) {
    return !widget.isForOtherUser
        ? OutlineButtonComponent(
            onPressed: () {},
            text: text.editProfile,
            isLoading: false,
            icon: Icons.edit,
          )
        : const SizedBox.shrink();
  }
}
