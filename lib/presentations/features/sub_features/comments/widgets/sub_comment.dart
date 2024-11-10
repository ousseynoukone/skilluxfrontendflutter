import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';

class SubComment extends StatefulWidget {
  final Comment comment;

  const SubComment({super.key, required this.comment});

  @override
  State<SubComment> createState() => _SubCommentState();
}

class _SubCommentState extends State<SubComment> with RouteAware {
  late final Logger _logger;
  final CommentService _commentService = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _logger = Logger();
    _commentService.getChildrenComments(widget.comment.id!,
        disableLoading: false);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // Handle route pop if needed
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _commentService.loadChildrenComments(widget.comment.id!,
          disableLoading: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: Get.height / 1.5,
      color: colorScheme.tertiary,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            CommentComponent(
              comment: widget.comment,
              displayReply: false,
            ),
            if (_commentService.isCommentChildCommentLoading.value)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height / 2),
                  child: CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  ),
                ),
              )
            else if (widget.comment.children.isNotEmpty)
              _showChildrenComments(widget.comment),
          ],
        ),
      ),
    );
  }

  Widget _showChildrenComments(Comment comment) {
    final childrenComments = comment.children;

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
