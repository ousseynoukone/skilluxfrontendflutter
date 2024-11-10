import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';
import 'package:get/get.dart';

class UserFollowing extends StatefulWidget {
  final int userId;

  const UserFollowing({super.key, this.userId = 0});

  @override
  _UserFollowingState createState() => _UserFollowingState();
}

class _UserFollowingState extends State<UserFollowing> {
  late UserProfileFollowService _service;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _service = UserProfileFollowService();
    _service.getUserFollowing(userId: widget.userId);

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _service.loadMoreUserFollowing();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final text = context.localizations;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(text.following),
      ),
      body: ValueListenableBuilder<List<UserDTO>>(
        valueListenable: _service.userNotifier,
        builder: (context, users, child) {
          if (users.isEmpty) {
            return Center(
                child: CircularProgressIndicator(
              color: colorScheme.onPrimary,
            ));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: ListTile(
                  tileColor: colorScheme.primary.withOpacity(0.3),
                  leading: displayUserPP(user.profilePicture),
                  title: Text(user.fullName),
                  subtitle: Text(
                    user.username,
                    style: textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(() => ForeignProfileScreen(
                          foreignUserId: user.id!,
                        ));
                  },
                ),
              );
            },
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
