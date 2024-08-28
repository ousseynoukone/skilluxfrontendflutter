import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:logger/logger.dart';

class CommentScreen extends StatefulWidget {
  final int postId;

  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with RouteAware {
  final Logger _logger = Logger();
  final CommentService _commentService = Get.put(CommentService());

  @override
  void initState() {
    super.initState();
    _commentService.getPostTopComments(widget.postId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget displayComment(List<Comment> comments) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: comments.length,
      itemBuilder: (context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CommentComponent(comment: comments[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        _commentService.obx(
          (state) => displayComment(state!),
          onLoading: CircularProgressIndicator(color: colorScheme.onPrimary),
          onEmpty:
              Center(child: Text(text.noComment, style: themeText.bodySmall)),
          onError: (error) => Text(text.errorUnexpected),
        ),
      ],
    );
  }
}
