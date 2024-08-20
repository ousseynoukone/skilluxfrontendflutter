import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class UserFollowing extends StatefulWidget {
  const UserFollowing({super.key});

  @override
  _UserFollowingState createState() => _UserFollowingState();
}

class _UserFollowingState extends State<UserFollowing> {
  final UserProfileFollowService _service =
      Get.find<UserProfileFollowService>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Load initial following data
    _service.getUserFollowging();

    // Set up scroll listener to load more following users
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load more following users when scrolled to the bottom
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
    final text = Get.context?.localizations;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(text!.following),
      ),
      body: GetBuilder<UserProfileFollowService>(
        builder: (service) {
          return service.obx(
            (state) {
              if (state == null || state.isEmpty) {
                return const Center(
                  child: Text('No following users found'),
                );
              }

              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final user = state[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      tileColor: colorScheme.primary.withOpacity(0.3),
                      leading: user.profilePicture.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user.profilePicture!),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(user.fullName),
                      subtitle: Text(
                        user.username,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => ForeignProfileScreen(
                              foreignUserId: user.id,
                            ));
                      },
                    ),
                  );
                },
                controller: _scrollController,
              );
            },
            onLoading: Center(
              child: CircularProgressIndicator(color: colorScheme.onPrimary),
            ),
            onError: (error) => Center(
              child: Text('Error: $error'),
            ),
            onEmpty: const Center(
              child: Text('No following users found'),
            ),
          );
        },
      ),
    );
  }
}
