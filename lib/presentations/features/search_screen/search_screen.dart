import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

import 'package:skilluxfrontendflutter/presentations/features/auth/widgets/navigation_bar/navigation_bar.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/helpers/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/sub_component/search_post.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/sub_component/search_user.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_form_field.dart';
import 'package:skilluxfrontendflutter/services/search_services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  final SearchService _searchService = Get.put(SearchService());

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(text.search),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormFieldComponent(
              prefixIcon: const Icon(Icons.search),
              labelText: text.search,
              hintText: text.searchHint,
              controller: controller,
              onChange: (String text) {
                searchTerm.value = text;
                _searchService.seachUser(text);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: TopNavigationBar(
              screenList: const [SearchUser(), SearchPost()],
              tabList: [
                Tab(
                  text: text.user,
                  icon: const Icon(Icons.person),
                ),
                Tab(text: text.content, icon: const Icon(Icons.article))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
