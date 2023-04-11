import 'package:circle/circle_user.dart';
import 'package:circle/utility/account_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/cupertino.dart';

class PostTextField extends StatefulWidget {
 PostTextField({Key? key}) : super(key: key);
 AuthenticationHandler auth = AuthenticationHandler();
  final TextEditingController postTextController = TextEditingController();

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
