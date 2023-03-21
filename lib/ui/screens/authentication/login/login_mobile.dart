import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle/resources/strings.dart' as res;

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(res.welcomeMessage, style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
            TextField(
              controller: _textFieldController,
            )],
          ),
        ),
      ),
    );
  }
}
