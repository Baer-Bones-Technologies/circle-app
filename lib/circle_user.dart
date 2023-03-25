import 'circle_partial_user.dart';

class CircleUser {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String bio;
  final String location;
  final int dateOfBirth;
  final List<CirclePartialUser> friends;
  final List<CirclePartialUser> friendRequests;
  final List<CirclePartialUser> friendRequestsSent;
  final List<CirclePartialUser> blockedUsers;

  CircleUser({
    required this.uid,
    this.email = "",
    this.displayName = "",
    this.photoUrl = "",
    this.phoneNumber = "",
    this.bio = "",
    this.location = "",
    this.dateOfBirth = 0,
    this.friends = const [],
    this.friendRequests = const [],
    this.friendRequestsSent = const [],
    this.blockedUsers = const [],
  });

  Map<String, dynamic> toFirebase() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'location': location,
      'dateOfBirth': dateOfBirth,
      'friends': friends.map((e) => e.toFirebase()).toList(),
      'friendRequests': friendRequests.map((e) => e.toFirebase()).toList(),
      'friendRequestsSent':
          friendRequestsSent.map((e) => e.toFirebase()).toList(),
      'blockedUsers': blockedUsers.map((e) => e.toFirebase()).toList(),
    };
  }

  CircleUser.fromFirebase(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        displayName = data['displayName'],
        photoUrl = data['photoUrl'],
        phoneNumber = data['phoneNumber'],
        bio = data['bio'],
        location = data['location'],
        dateOfBirth = data['dateOfBirth'],
        friends = (data['friends'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        friendRequests = (data['friendRequests'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        friendRequestsSent = (data['friendRequestsSent'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        blockedUsers = (data['blockedUsers'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList();
}
