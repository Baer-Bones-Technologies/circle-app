import 'dart:core';
import 'package:circle/models/circle_comment.dart';
import 'package:circle/models/circle_partial_user.dart';

class CirclePost {
  String id = "";
  String? content = "";
  String? imageUrl = "";
  CirclePartialUser user = CirclePartialUser(uid : "invalid");
  int createdAt = DateTime.now().millisecondsSinceEpoch;
  int? updatedAt;
  List<CircleComment> comments = [];
  int likes = 0;

  CirclePost({
    required this.id,
    this.content,
    this.imageUrl,
    required this.user,
    required this.createdAt,
    this.updatedAt,
    this.comments = const [],
    this.likes = 0,
  });

  CirclePost.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    content = map['content'];
    imageUrl = map['imageUrl'];
    user = CirclePartialUser.fromMap(map['user']);
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'user': user.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  CirclePost.fromFirebase(Map<String, dynamic> data) {
    id = data['id'];
    content = data['content'];
    imageUrl = data['imageUrl'];
    user = CirclePartialUser.fromFirebase(data['user']);
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'user': user.toFirebase(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
