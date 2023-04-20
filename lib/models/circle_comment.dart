import 'package:circle/models/circle_partial_user.dart';
import 'package:circle/models/circle_post.dart';
import 'package:flutter/cupertino.dart';

class CircleComment {
  final String id;
  final CirclePartialUser author;
  final String content;
  final int createdAt;
  final int updatedAt;
  int likes;
  final String photo;
  final CircleComment? parentComment;
  final CirclePost parentPost;
  final List<CircleComment> replies;
  ValueNotifier<int> likesCounter = ValueNotifier(0);

  CircleComment({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    this.updatedAt = 0,
    required this.photo,
    this.parentComment,
    required this.parentPost,
    this.replies = const [],
    this.likes = 0,
  }) {
    likesCounter.value = likes;
  }

  CircleComment.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        author = CirclePartialUser.fromMap(map['author']),
        content = map['content'],
        createdAt = map['createdAt'],
        updatedAt = map['updatedAt'],
        photo = map['photo'],
        parentComment =
            map['parent'] != null ? CircleComment.fromMap(map['parent']) : null,
        parentPost = map['parentPost'] != null ? 
        CirclePost.fromMap(map['parentPost']) 
        : CirclePost(id: "", user: CirclePartialUser(uid: ""), createdAt: 0),
        replies = map['replies'] != null
            ? List<CircleComment>.from(
                map['replies'].map((x) => CircleComment.fromMap(x)))
            : [],
        likes = map['likes'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author.toMap(),
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'photo': photo,
      'parent': parentComment?.toMap(),
      'replies': replies.map((x) => x.toMap()).toList(),
    };
  }

  CircleComment.fromFirebase(Map<String, dynamic> data)
      : id = data['id'],
        author = CirclePartialUser.fromFirebase(data['author']),
        content = data['content'],
        createdAt = data['createdAt'],
        updatedAt = data['updatedAt'],
        photo = data['photo'],
        parentComment = data['parent'] != null
            ? CircleComment.fromFirebase(data['parent'])
            : null,
            parentPost = data['parentPost'] != null
            ? CirclePost.fromFirebase(data['parentPost'])
            : CirclePost(id: "", user: CirclePartialUser(uid: ""), createdAt: 0),
        replies = data['replies'] != null
            ? List<CircleComment>.from(
                data['replies'].map((x) => CircleComment.fromFirebase(x)))
            : [],
        likes = data['likes'];

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'author': author.toFirebase(),
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'photo': photo,
      'parent': parentComment?.toFirebase(),
      'replies': replies.map((x) => x.toFirebase()).toList(),
    };
  }

  addLike() {
    likesCounter.value++;
  }

  removeLike() {
    likesCounter.value--;
  }

  reply(CirclePartialUser user, String content, String? photo) {}

  edit(String content) {}

  delete() {}

  report() {}

  share() {}

  copy() {}

  quote() {}

  translate() {}

  static createComment(
    CirclePartialUser user, {
    String content = "",
    String? photo,
    CircleComment? parentComment,
    CirclePost? parentPost,
  }) {
    int now = DateTime.now().millisecondsSinceEpoch;
    String commentId = _buildCommentId(user);
    CircleComment comment = CircleComment(id: commentId, author: user, content: content, createdAt: now, photo: photo ?? "", parentComment: parentComment, parentPost: parentPost!);
    parentComment?.replies.add(comment);

    
  }

  /// This is the function responsible for building the comment ID
  static String _buildCommentId(CirclePartialUser user) {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    String timeHash = time.hashCode.toString().substring(time.length - 6, time.length - 1);
    String userId = user.uid;
    String userIdHash = userId.hashCode.toString().substring(userId.length - 6, userId.length - 1);
    return timeHash + userIdHash;
  }
}
