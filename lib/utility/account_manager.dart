import 'package:circle/utility/auth_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../circle_user.dart';

class AccountManager{
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth;
  AccountManager(this._auth);
  /// This function is used to create a new user in the database
void createUser(CircleUser user){
  _database.collection('users').doc(_auth.currentUser?.uid).set(user.toFirebase());
}

/// This function is used to get a user from the database
Future<CircleUser> getUser(String uid) async {
  DocumentSnapshot user = await _database.collection('users').doc(uid).get();
  return CircleUser.fromFirebase(user.data() as Map<String, dynamic>);
}
}