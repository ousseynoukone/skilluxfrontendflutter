import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:logger/logger.dart';

class Comment {
  final int? id;
  final String text;
  final bool? isModified;
  final DateTime createdAt;
  int like;
  final UserDTO user;
  final UserDTO? target;
  final int? targetId;
  final int? userId;
  int descendantCount;
  final int? postId;
  final int? parentId;
  final DateTime? updatedAt;
  List<Comment> children;

  static final Logger _logger = Logger();

  Comment({
    required this.text,
    required this.user,
    required this.createdAt,
    required this.like,
    this.id,
    this.isModified,
    this.target,
    this.descendantCount = 0,
    this.postId,
    this.parentId,
    this.targetId,
    this.userId,
    this.updatedAt,
    List<Comment>? children,
  }) : children = children ?? [];

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      isModified: json['isModified'],
      createdAt: DateTime.parse(json['createdAt']),
      like: json['like'],
      user:  UserDTO.fromBody(json['user']),
      target: json['target'] == null ? null : UserDTO.fromBody(json['target']),
      descendantCount: json['descendantCount'] ?? 0,
      postId: json['postId'],
      userId: json['userId'],
      parentId: json['parentId'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  static Comment createNewComment(CommentDto commentDto, UserDTO user,
      {UserDTO? target}) {
    return Comment(
      id: commentDto.id,
      text: commentDto.text!,
      user: user,
      postId: commentDto.postId,
      parentId: commentDto.parentId,
      userId: commentDto.userId,
      target: target,
      isModified: null,
      createdAt: DateTime.now(),
      like: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isModified': isModified,
      'createdAt': createdAt.toIso8601String(),
      'like': like,
      'targetId': targetId,
      'descendantCount': descendantCount.toString(),
      'postId': postId,
      'parentId': parentId,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  void likeComment() {
    like += 1;
  }

  void unLikeComment() {
    like -= 1;
  }

  void incrementDescendantCount() {
    descendantCount += 1;
  }

  void decrementDescendantCount() {
    descendantCount -= 1;
  }

  Comment clone() {
    return Comment(
      id: id,
      text: text,
      isModified: isModified,
      createdAt: createdAt,
      like: like,
      user: user.clone(),
      target: target?.clone(),
      descendantCount: descendantCount,
      targetId: targetId,
      postId: postId,
      parentId: parentId,
      updatedAt: updatedAt,
      children: List.from(children),
    );
  }

  Comment copyWith({
    int? id,
    String? text,
    bool? isModified,
    DateTime? createdAt,
    int? like,
    UserDTO? user,
    UserDTO? target,
    int? targetId,
    int? userId,
    int? descendantCount,
    int? postId,
    int? parentId,
    DateTime? updatedAt,
    List<Comment>? children,
  }) {
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      isModified: isModified ?? this.isModified,
      createdAt: createdAt ?? this.createdAt,
      like: like ?? this.like,
      user: user ?? this.user,
      target: target ?? this.target,
      targetId: targetId ?? this.targetId,
      userId: userId ?? this.userId,
      descendantCount: descendantCount ?? this.descendantCount,
      postId: postId ?? this.postId,
      parentId: parentId ?? this.parentId,
      updatedAt: updatedAt ?? this.updatedAt,
      children: children ?? List.from(this.children),
    );
  }

  void log() {
    _logger.d('Comment id:  $id');
    _logger.d('Text: $text');
    _logger.d('User: ${user.username}');
    _logger.d('Created at: $createdAt');
    _logger.d('Likes: $like');
    _logger.d('Is modified: $isModified');
    _logger.d('Target: ${target?.username}');
    _logger.d('Descendant count: $descendantCount');
    _logger.d('Post ID: $postId');
    _logger.d('Parent ID: $parentId');
    _logger.d('Updated at: $updatedAt');
    _logger.d('Children count: ${children.length}');
  }
}
