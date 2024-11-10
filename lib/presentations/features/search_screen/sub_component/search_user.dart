import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/services/search_services/search_service.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final SearchService _searchService = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      _searchService.loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeText = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() => ListView.builder(
        controller: _scrollController,
        itemCount: _searchService.users.length,
        itemBuilder: (context, int index) {
          User user = _searchService.users[index];
          return InkWell(
            onTap: () {
              Get.to(() => ForeignProfileScreen(foreignUserId: user.id));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: displayUserPreview(user,
                      zeroPadding: true,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        decoration: BoxDecoration(
                            color: colorScheme.secondary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '@${user.username}',
                          style: themeText.bodySmall,
                        ),
                      )),
                ),
              ),
            ),
          );
        }));
  }
}
