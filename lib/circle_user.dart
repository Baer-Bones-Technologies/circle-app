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
  final List<CirclePartialUser> followers;
  final List<CirclePartialUser> followed;
  final List<CirclePartialUser> followRequestsSent;
  final List<CirclePartialUser> followRequestsReceived;
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
    this.followers = const [],
    this.followed = const [],
    this.followRequestsReceived = const [],
    this.followRequestsSent = const [],
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
      'followers': followers.map((e) => e.toFirebase()).toList(),
      'followed': followed.map((e) => e.toFirebase()).toList(),
      'followRequestsSent':
          followRequestsSent.map((e) => e.toFirebase()).toList(),
      'followRequestsReceived':
          followRequestsReceived.map((e) => e.toFirebase()).toList(),
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
        followers = (data['followers'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        followed = (data['followed'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        followRequestsSent = (data['followRequestsSent'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList(),
        followRequestsReceived =
            (data['followRequestsReceived'] as List<dynamic>)
                .map((e) => CirclePartialUser.fromFirebase(e))
                .toList(),
        blockedUsers = (data['blockedUsers'] as List<dynamic>)
            .map((e) => CirclePartialUser.fromFirebase(e))
            .toList();
}
