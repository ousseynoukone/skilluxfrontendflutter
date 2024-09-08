import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class SubComment extends StatefulWidget {
  final Comment comment;

  const SubComment({super.key, required this.comment});

  @override
  State<SubComment> createState() => _SubCommentState();
}

class _SubCommentState extends State<SubComment> {
  late final Logger _logger;
  bool isReplyShown = false;
  final CommentService _commentService = Get.find();

  @override
  void initState() {
    super.initState();
    _logger = Logger();
    _commentService.loadChildrenComment(widget.comment.id,
        disableLoading: true);
  }

  @override
  void dispose() {
    _commentService.unloadChildrenComments(widget.comment.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: GetX<CommentService>(builder: (controller) {
            var updatedComment = controller.comments.firstWhere(
                (c) => c.id == widget.comment.id,
                orElse: () => widget.comment);
            return Column(
              children: [
                CommentComponent(
                  comment: widget.comment,
                  displayReply: false,
                ),
                Obx(() {
                  if (_commentService.isCommentChildCommentLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  } else {
                    if (updatedComment.children.isNotEmpty) {
                      return showChildrenComments(updatedComment);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                })
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget showChildrenComments(Comment comment) {
    List<Comment> childrenComments = comment.children;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: childrenComments.map((childComment) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CommentComponent(
              comment: childComment,
              displayReply: false,
              isColorTransparent: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
