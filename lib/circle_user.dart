class CircleUser{

  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String bio;
  final String location;

  CircleUser({
    required this.uid,
    this.email = "",
    this.displayName = "",
    this.photoUrl = "",
    this.phoneNumber = "",
    this.bio = "",
    this.location = "",
  });

  Map<String, dynamic> toFirebase(){
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'location': location,
    };
  }

  CircleUser.fromFirebase(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        displayName = data['displayName'],
        photoUrl = data['photoUrl'],
        phoneNumber = data['phoneNumber'],
        bio = data['bio'],
        location = data['location'];
}