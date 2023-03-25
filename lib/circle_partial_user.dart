class CirclePartialUser {
  final String uid;
  final String displayName;
  final String photoUrl;
  final int dateOfBirth;

  static final DateTime _defaultDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  CirclePartialUser({
    this.dateOfBirth = 0,
    required this.uid,
    this.displayName = "",
    this.photoUrl = "",
  });

  Map<String, dynamic> toFirebase() {
    return {
      'uid': uid,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'dateOfBirth': dateOfBirth,
    };
  }

  CirclePartialUser.fromFirebase(Map<String, dynamic> data)
      : uid = data['uid'],
        displayName = data['displayName'],
        photoUrl = data['photoUrl'],
        dateOfBirth = data['dateOfBirth'];
}
