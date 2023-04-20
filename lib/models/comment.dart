import 'package:circle/models/circle_partial_user.dart';

class Comment {
  /// This comments ID
  final String id;

  /// Post ID
  final String parentPostId;

  /// Thread ID, will be set as its own [id] unless attached to a
  /// thread in which it will be the parent comments [id]
  final String parentThreadId;

  /// Comments User
  final CirclePartialUser user;

  /// Comments Body
  final String body;

  /// Comments date of publishing
  final int date;

  /// Comment Likes
  final List<CirclePartialUser> likes;

  Comment(
      {required this.id,
      required this.parentPostId,
      required this.parentThreadId,
      required this.user,
      required this.body,
      required this.date,
      required this.likes});
}
