// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:circle/utility/security/password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  /// Test password encoding to ensure plain text passwords are not stored in the database
  test('Password encoding', () {
    String password = 'password';
    Password encodedPassword = Password(password);
    expect(encodedPassword.value, isNot(password));
  });
}
