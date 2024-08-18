import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfo extends StatefulWidget {
  final User userInfoDto;
  final bool isForOtherUser;
  const UserInfo(
      {super.key, required this.userInfoDto, this.isForOtherUser = false});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    User u = widget.userInfoDto;
    final AppLocalizations text = context.localizations;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(u.profilePicture!),
                radius: 60,
              ),
              userStats(u, text, textTheme),
            ],
          ),
          userInfo(u, textTheme, text, widget.isForOtherUser),
        ],
      ),
    );
  }
}

Widget userInfo(
    User u, TextTheme textTheme, AppLocalizations text, bool isForOtherUser) {
  return Column(
    children: [
      const SizedBox(height: 5),
      Text(u.fullName.toString()),
      const SizedBox(height: 5),
      u.profession != null
          ? Text(u.profession!, style: textTheme.bodySmall)
          : const SizedBox.shrink(),
      const SizedBox(height: 10),
      followButton(text, textTheme, isForOtherUser),
      editProfileButton(text, textTheme, isForOtherUser)
    ],
  );
}

Widget userStats(User user, AppLocalizations text, TextTheme textTheme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(user.nbFollowers.toString()),
            const SizedBox(
              height: 8,
            ),
            Text(
              text.follower,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(user.nbFollowings.toString()),
            const SizedBox(
              height: 8,
            ),
            Text(
              text.following,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(user.nbPosts.toString()),
            const SizedBox(
              height: 8,
            ),
            Text(text.publication, style: textTheme.bodySmall),
          ],
        ),
      ),
    ],
  );
}

Widget followButton(
    AppLocalizations text, TextTheme textTheme, bool isForOtherUser) {
  return isForOtherUser
      ? OutlineButtonComponent(
          onPressed: () {},
          text: text.follow,
          isLoading: false,
          icon: Icons.add_alert_rounded,
        )
      : const SizedBox.shrink();
}

Widget editProfileButton(
    AppLocalizations text, TextTheme textTheme, bool isForOtherUser) {
  return !isForOtherUser
      ? OutlineButtonComponent(
          onPressed: () {},
          text: text.editProfile,
          isLoading: false,
          icon: Icons.edit,
        )
      : const SizedBox.shrink();
}
