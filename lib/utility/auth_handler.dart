import 'package:circle/circle_user.dart';
import 'package:circle/utility/account_manager.dart';
import 'package:circle/utility/security/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circle/resources/strings.dart' as res;

/// Class is used to handle authentication states and functions
class AuthenticationHandler {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final AccountManager _accountManager = AccountManager(_auth);

  User? user = _auth.currentUser;

  /// This function is used to get the current authentication state
  ///
  /// **Example**:
  /// ```dart
  /// AuthenticationHandler().getAuthenticationState();
  /// ```
  ///
  /// **Returns**:
  /// *State*
  ///
  /// **Possible Values**:
  /// *State.loggedIn*
  /// *State.loggedOut*
  /// *State.loading*
  ///
  /// **Example**:
  /// ```dart
  /// AuthenticationHandler().getAuthenticationState().then((value) {
  ///   if (value == State.loggedIn) {
  ///     // User is logged in
  ///   } else if (value == State.loggedOut) {
  ///     // User is logged out
  ///   } else if (value == State.loading) {
  ///     // User is loading
  ///   }
  /// });
  /// ```
  AuthState getAuthenticationState() {
    switch (_auth.currentUser) {
      case null:
        return AuthState.loggedOut;
      default:
        return AuthState.loggedIn;
    }
  }

  Stream<AuthState> getAuthStateStream() {
    return _auth.authStateChanges().map((event) {
      switch (event) {
        case null:
          return AuthState.loggedOut;
        default:
          return AuthState.loggedIn;
      }
    });
  }

  /// This function is used to sign in a user with email and password
  /// and receive user data in return if successful.
  ///
  /// While receiving user data, the function will also set the current
  /// authentication state to State.loading. Once the user data is received
  /// the authentication state will be set to State.loggedIn.

  /// **Example**:
  /// ```dart
  /// AuthenticationHandler().signInWithEmailAndPassword(email, password);
  /// ```
  ///
  /// **Parameters**:
  /// *email*: String
  /// *password*: String
  ///
  /// **Returns**:
  /// *User*

  Future<CircleUser?> signInWithEmailAndPassword(
      String email, Password password) async {
    CircleUser? user;
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password.value);
      if (credential.user != null) {
        user = _accountManager.getUser(credential.user!.uid) as CircleUser?;
      }
      return user;
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw Exception(res.noUserError);
        } else if (e.code == 'wrong-password') {
          throw Exception(res.wrongPasswordError);
        }
      }
      throw Exception(e.toString());
    }
  }

  /// This function is used to create a new user with email and password
  /// and receive user data in return if successful.
  ///
  /// While receiving user data, the function will also set the current
  /// authentication state to State.loading. Once the user data is received
  /// the authentication state will be set to State.loggedIn.
  Future<CircleUser?> createUserWithEmailAndPassword(
      String email, Password password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password.value);
      credential.user!.sendEmailVerification();
      _accountManager.createUser(
          _accountManager.getUser(credential.user!.uid) as CircleUser);
      return _accountManager.getUser(credential.user!.uid) as CircleUser?;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception(res.passwordWeakError);
      } else if (e.code == 'email-already-in-use') {
        throw Exception(res.emailInUseError);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  /// This function is used to ensure that the user is at lease 16 years old
  /// before they can create an account.
  /// **Example**:
  /// ```dart
  /// AuthenticationHandler().isUserOldEnough(birthDate);
  /// ```
  /// **Parameters**:
  /// *birthDate*: DateTime
  /// **Returns**:
  /// *bool*
  /// **Example**:
  /// ```dart
  /// AuthenticationHandler().isUserOldEnough(birthDate).then((value) {
  ///  if (value) {
  ///  // User is old enough
  ///  } else {
  ///  // User is not old enough
  ///  }
  bool isUserOldEnough(DateTime birthDate) {
    final DateTime now = DateTime.now();
    final int age = now.year - birthDate.year;
    final int month1 = now.month;
    final int month2 = birthDate.month;
    if (age > 16) {
      return true;
    } else if (age == 16) {
      if (month1 >= month2) {
        return true;
      }
    }
    return false;
  }
}

enum AuthState { loggedIn, loggedOut }
