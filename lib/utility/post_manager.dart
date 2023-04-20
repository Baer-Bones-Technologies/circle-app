import 'package:circle/models/circle_comment.dart';
import 'package:circle/models/circle_partial_user.dart';
import 'package:circle/models/circle_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  ContentManager._();

  /// This is the function responsible for building a post or comment ID
  static String buildId(CirclePartialUser user,
      {ContentType type = ContentType.post}) {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    String timeHash =
        time.hashCode.toString().substring(time.length - 6, time.length - 1);
    String userId = user.uid;
    String userIdHash = userId.hashCode
        .toString()
        .substring(userId.length - 6, userId.length - 1);
    switch(type){
      case ContentType.post:
        return "P-$timeHash$userIdHash";
      case ContentType.comment:
        return "C-$timeHash$userIdHash";
    }
  }

  /// This is the function responsible for creating a post to the database
  Future<void> createPost(
      {required CirclePartialUser user,
      String content = "",
      String? imageUrl}) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    String postId = buildId(user, type: ContentType.post);
    await _db.collection('posts').doc(postId).set({
      'id': postId,
      'content': content,
      'imageUrl': imageUrl,
      'user': user.toFirebase(),
      'createdAt': now,
      'updatedAt': now,
    });
  }
  
  /// This is the function responsible for creating a comment to the database
  Future<void> createComment(
      {required CirclePartialUser user,
      String content = "",
      String? photo,
      CircleComment? parentComment,
      required CirclePost parentPost}) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    String commentId = buildId(user, type: ContentType.comment);
    await _db.collection('posts/${parentPost.id}/comments').doc(commentId).set({
      'id': commentId,
      'author': user.toFirebase(),
      'content': content,
      'createdAt': now,
      'updatedAt': now,
      'photo': photo,
      'parent': parentComment?.toFirebase(),
      'replies': [],
    });
  }

  ///This is the function responsible for liking a post on the database
  Future<void> likePost({required CirclePartialUser user, required CirclePost post}) async {
    await _db.collection('posts/${post.id}/likes').doc(user.uid).set({
      'user': user.toFirebase(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  ///This is the function responsible for liking a comment on the database
  Future<void> likeComment({required CirclePartialUser user, required CircleComment comment}) async {
    await _db.collection('posts/${comment.parentPost.id}/comments/${comment.id}/likes').doc(user.uid).set({
      'user': user.toFirebase(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}



enum ContentType {
  post,
  comment,
}
