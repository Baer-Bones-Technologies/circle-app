import 'package:circle/resources/strings.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/common/logo.dart';
import 'package:circle/ui/common/primary_button.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/primary_text_input.dart';

class RegistrationMobile extends StatefulWidget {
  const RegistrationMobile({Key? key}) : super(key: key);

  @override
  State<RegistrationMobile> createState() => _RegistrationMobileState();
}

class _RegistrationMobileState extends State<RegistrationMobile> {
  RegistrationState registrationState = RegistrationState.admin;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final nextButtonStatesController = MaterialStatesController();
  final _registrationComplete = Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text('Please enter your email address',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40),
      ),
      SingleLineInput(
        label: emailLabel,
        hintText: emailHint,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CircleTheme.primary,
        floatingActionButton: PrimaryButton(
          text: registrationState == RegistrationState.registrationComplete
              ? 'Complete'
              : 'Next',
          width: 75,
          height: 50,
          onPressed: () {
            setState(() {
              switch (registrationState) {
                case RegistrationState.admin:
                // TODO: Create account on Firebase Auth
                  registrationState = RegistrationState.user;
                  break;
                case RegistrationState.user:
                // TODO: Create user account on Firebase Firestore
                  registrationState = RegistrationState.registrationComplete;
                  break;
                case RegistrationState.registrationComplete:
                  break;
              }
            });
          },
        ),
        body: SafeArea(
            child: registrationState == RegistrationState.admin
                ? AdminRegistration(emailTextController: emailTextController,
                passwordTextController: passwordTextController,
                confirmPasswordTextController: confirmPasswordTextController)
                : registrationState == RegistrationState.user
                ? UserRegistration(usernameTextController: usernameTextController)
                : _registrationComplete
        ));
  }
}

class AdminRegistration extends StatelessWidget {
  const AdminRegistration(
      {Key? key, required this.emailTextController, required this.passwordTextController, required this.confirmPasswordTextController})
      : super(key: key);

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController confirmPasswordTextController;

  @override
  Widget build(BuildContext context) {
    final ui = UIManager(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Logo(),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Please enter your email address',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleLineInput(
                label: emailLabel,
                hintText: emailHint,
                controller: emailTextController,
                width: ui.getMaxWidth(width: .8),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserRegistration extends StatelessWidget {
  const UserRegistration({Key? key, required this.usernameTextController})
      : super(key: key);

  final TextEditingController usernameTextController;
  final isUsernameAvailable = UsernameAvailability.unknown;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('What should we call you?',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        Row(
          children: [
            const Text('_'),
            SingleLineInput(
              label: emailLabel,
              hintText: emailHint,
              controller: usernameTextController,
            ),
          ],
        )
      ],
    );
  }
}

enum UsernameAvailability { available, unavailable, unknown }


enum RegistrationState { admin, user, registrationComplete }
