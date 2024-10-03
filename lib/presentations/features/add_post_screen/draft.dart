import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_format.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

class Draft extends StatefulWidget {
  const Draft({super.key});

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  final HivePostsPersistence hivePostsPersistence = Get.find();
  List<Post> posts = [];
  bool isLoading = true;
  final Logger _logger = Logger();
  final AddPostSysService _addPostSysService = Get.find();

  @override
  void initState() {
    super.initState();
    getDraftPosts();
  }

  void displayDraftPost(Post post) {
    _addPostSysService.addPost(post);
    _addPostSysService.isFromDraft.value++;
    Get.back();
  }

  void getDraftPosts() async {
    try {
      final fetchedPosts = await hivePostsPersistence.readAllPosts();

      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      _logger.d('Error fetching posts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteDraftPost(dynamic key) async {
    await hivePostsPersistence.deleteOnePost(key);
    getDraftPosts();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(text.draft),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? Center(
                  child: getCustomChip(text.noDraft, null,
                      isBackgroundTransparent: true))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListTile(
                        leading: post.headerBinaryImage?.binaryMedia != null
                            ? Image.memory(
                                post.headerBinaryImage!.binaryMedia!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(post.title),
                        subtitle: Text(
                          post.createdAt != null
                              ? formatDateTime(post.createdAt)
                              : text.dateUnknown,
                        ),
                        trailing: IconButton.filled(
                            color: ColorsTheme.error,
                            onPressed: () {
                              deleteDraftPost(post.id);
                            },
                            icon: const Icon(Icons.delete)),
                        onTap: () {
                          displayDraftPost(post);
                        },
                        tileColor: colorScheme.primary);
                  },
                ),
    );
  }
}
