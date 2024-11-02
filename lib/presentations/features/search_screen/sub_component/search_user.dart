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

  @override
  Widget build(BuildContext context) {
    var themeText = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() => ListView.builder(
        itemCount: _searchService.users.length,
        itemBuilder: (context, int index) {
          User user = _searchService.users[index];
          return InkWell(
            onTap: () {
              Get.to(() => ForeignProfileScreen(foreignUserId: user.id));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: displayUserPreview(user,
                    zeroPadding: true,
                    trailing: Text(
                      '@${user.username}',
                      style: themeText.bodySmall,
                    )),
              ),
            ),
          );
        }));
  }
}
