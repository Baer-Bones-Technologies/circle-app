import 'package:circle/models/circle_partial_user.dart';
import 'package:circle/models/comment.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:flutter/cupertino.dart';

class Post {
  final String id;
  final Post childPostId;
  final CirclePartialUser user;
  final String body;
  final String link;
  final List<CirclePartialUser> likes;
  final List<Comment> comments;

  // TODO: Add marketplace products to posts

  Post({
    required this.id,
    required this.user,
    required this.childPostId,
    required this.body,
    required this.link,
    required this.likes,
    required this.comments
  });

  Widget post(BuildContext context){
    UIManager ui = UIManager(context);
    return Container(
      color: CircleTheme.secondary.value,
      width: ui.getMaxWidth(width: .80),
      padding: const EdgeInsets.all(10),
    );
  }

  Widget postPreview(BuildContext context){
    UIManager ui = UIManager(context);
    return Container(
      color: CircleTheme.secondary.value,
      width: ui.getMaxWidth(width: .80),
      padding: const EdgeInsets.all(10),
    );
  }
}