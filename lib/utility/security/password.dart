class Password{
  String value = '';
  final String _value;

  Password(this._value){
    value = _hashPassword(_value);
  }

  /// This function is used to take in plaintext password and return a hashed password
///
/// **Example**:
/// ```dart
/// Password().hashPassword('password');
/// ```
String _hashPassword(String password) {
  String hashedPassword = '';
  for (int i = 0; i < password.length; i++) {
    hashedPassword += password[i].codeUnitAt(0).toString();
  }
  return hashedPassword;
}
}