import 'dart:developer';

import 'package:circle/circle_user.dart';
import 'package:circle/resources/constants.dart';
import 'package:circle/resources/strings.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/common/common_ui.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/account_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:circle/utility/security/password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ButtonState nextButtonState = ButtonState.disabled;

class RegistrationMobile extends StatefulWidget {
  RegistrationMobile({Key? key}) : super(key: key);

  RegistrationState registrationState = RegistrationState.admin;
  DateTime dateOfBirth = defaultBirthDate;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final isUsernameAvailable =
      ValueNotifier<UsernameAvailability>(UsernameAvailability.unknown);
  final nextButtonStatesController = MaterialStatesController();
  final _registrationComplete = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.check_circle_outline,
              size: 100, color: CircleTheme.secondary),
          const SizedBox(height: 20),
          const Text(
            registrationCompleteLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ]),
      ]);
  CircleUser? user;

  bool checkTextFormat(TextEditingController controller, TextFormat format) {
    switch (format) {
      case TextFormat.email:
        RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
        return emailRegex.hasMatch(controller.text);
      case TextFormat.password:
        RegExp passwordRegex =
            RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
        return passwordRegex.hasMatch(controller.text);
      case TextFormat.username:
        RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,15}$');
        return usernameRegex.hasMatch(controller.text);
      default:
        return false;
    }
  }

  bool isButtonReady() {
    bool checksOut = false;

    switch (registrationState) {
      case RegistrationState.admin:
        checksOut = emailTextController.text.isNotEmpty &&
            passwordTextController.text.isNotEmpty &&
            confirmPasswordTextController.text.isNotEmpty &&
            AuthenticationHandler().isUserOldEnough(dateOfBirth) &&
            passwordTextController.text == confirmPasswordTextController.text &&
            checkTextFormat(emailTextController, TextFormat.email) &&
            checkTextFormat(passwordTextController, TextFormat.password);
        break;
      case RegistrationState.user:
        checksOut =
            isUsernameAvailable.value == UsernameAvailability.available &&
                usernameTextController.text.isNotEmpty;
        break;
      case RegistrationState.registrationComplete:
        checksOut = true;
        break;
    }

    log('Is button ready? $checksOut');
    return checksOut;
  }

  @override
  State<RegistrationMobile> createState() => _RegistrationMobileState();
}

class _RegistrationMobileState extends State<RegistrationMobile> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: defaultBirthDate,
        firstDate: DateTime(1900, 1),
        initialEntryMode: DatePickerEntryMode.calendar,
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.dateOfBirth = picked;
        nextButtonState =
            AuthenticationHandler().isUserOldEnough(widget.dateOfBirth)
                ? ButtonState.enabled
                : ButtonState.disabled;
        log('Is button enabled? $nextButtonState');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationHandler auth = AuthenticationHandler();
    AccountManager accountManager = AccountManager(auth.getAuthInstance());
    return Scaffold(
        backgroundColor: CircleTheme.primary,
        floatingActionButton: PrimaryButton(
          text:
              widget.registrationState == RegistrationState.registrationComplete
                  ? 'Complete'
                  : 'Next',
          width: 75,
          height: 50,
          onPressed: () {
            setState(() {
              if (nextButtonState == ButtonState.enabled) {
                switch (widget.registrationState) {
                  case RegistrationState.admin:
                    // TODO: Create account on Firebase Auth
                    Password password =
                        Password(widget.passwordTextController.text);
                    String email = widget.emailTextController.text;
                    auth.createUserWithEmailAndPassword(email, password).then(
                        (value) {
                      widget.user = value;
                      if (widget.user != null) {
                        log('User created: ${widget.user!.uid}');
                        if (widget.user != null) {
                          setState(() {
                            widget.registrationState = RegistrationState.user;
                          });
                        } else if (widget.user == null) {
                          throw Exception('Error creating user');
                        }
                      }
                    }, onError: (error) {
                      log('Error creating user: $error');
                    });

                    break;
                  case RegistrationState.user:
                    // TODO: Create user account on Firebase Firestore
                    widget.user!.displayName =
                        widget.usernameTextController.text;
                    try {
                      accountManager.updateUser(widget.user!);
                    } catch (e) {
                      log('Error creating user: $e');
                      if (e is FirebaseAuthException) {
                        log('Error code: ${e.code}');
                      }
                    }
                    if (widget.user != null) {
                      setState(() {
                        widget.registrationState =
                            RegistrationState.registrationComplete;
                      });
                    }
                    break;
                  case RegistrationState.registrationComplete:
                    break;
                }
              } else {}
            });
          },
        ),
        body: SafeArea(
            child: widget.registrationState == RegistrationState.admin
                ? AdminRegistration(
                    emailTextController: widget.emailTextController,
                    passwordTextController: widget.passwordTextController,
                    birthDateTextController: TextEditingController(
                        text:
                            '${widget.dateOfBirth.month}/${widget.dateOfBirth.day}/${widget.dateOfBirth.year}'),
                    confirmPasswordTextController:
                        widget.confirmPasswordTextController,
                    dateSelection: () => {_selectDate(context)},
                    dateOfBirth: widget.dateOfBirth,
                    enabled: nextButtonState == ButtonState.enabled)
                : widget.registrationState == RegistrationState.user
                    ? UserRegistration(
                        usernameTextController: widget.usernameTextController,
                        isUsernameAvailable: widget.isUsernameAvailable,
                      )
                    : widget._registrationComplete));
  }
}

class AdminRegistration extends StatefulWidget {
  AdminRegistration(
      {Key? key,
      required this.emailTextController,
      required this.birthDateTextController,
      required this.passwordTextController,
      required this.confirmPasswordTextController,
      required this.dateSelection,
      required this.dateOfBirth,
      required this.enabled})
      : super(key: key);

  final TextEditingController emailTextController;
  final TextEditingController birthDateTextController;
  final TextEditingController passwordTextController;
  final TextEditingController confirmPasswordTextController;
  final Function() dateSelection;
  DateTime dateOfBirth;
  bool enabled = false;

  @override
  State<AdminRegistration> createState() => _AdminRegistrationState();
}

class _AdminRegistrationState extends State<AdminRegistration> {
  @override
  Widget build(BuildContext context) {
    final ui = UIManager(context);

    bool errorThrownPassword = false;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            const SizedBox(height: 20),
            const Text(
              welcomeMessage,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  LabelTextInput(
                    label: emailLabel,
                    hintText: emailHint,
                    controller: widget.emailTextController,
                    width: ui.getMaxWidth(width: .8),
                    onChanged: (value) {
                      setState(() {
                        nextButtonState = RegistrationMobile().isButtonReady()
                            ? ButtonState.enabled
                            : ButtonState.disabled;
                      });
                    },
                  ),
                  LabelTextInput(
                    label: dateOfBirthLabel,
                    onTap: widget.dateSelection,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    controller: widget.birthDateTextController,
                    onChanged: (value) {
                      setState(() {
                        widget.dateOfBirth = DateTime.parse(value);
                        nextButtonState = RegistrationMobile().isButtonReady()
                            ? ButtonState.enabled
                            : ButtonState.disabled;
                        log('enabled: ${nextButtonState == ButtonState.enabled}');
                      });
                    },
                  ),
                  LabelTextInput(
                      label: passwordLabel,
                      hintText: passwordHint,
                      controller: widget.passwordTextController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          nextButtonState = RegistrationMobile().isButtonReady()
                              ? ButtonState.enabled
                              : ButtonState.disabled;
                        });
                      },
                      width: ui.getMaxWidth(width: .8)),
                  LabelTextInput(
                      label: confirmPasswordLabel,
                      hintText: passwordHint,
                      controller: widget.confirmPasswordTextController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          errorThrownPassword =
                              widget.passwordTextController.text != value;

                          nextButtonState = RegistrationMobile().isButtonReady()
                              ? ButtonState.disabled
                              : ButtonState.enabled;

                          log('errorThrown: $errorThrownPassword');
                          log('enabled: ${nextButtonState == ButtonState.enabled}');
                        });
                      },
                      errorText: passwordMismatchError,
                      errorThrown: errorThrownPassword,
                      width: ui.getMaxWidth(width: .8)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRegistration extends StatefulWidget {
  UserRegistration(
      {Key? key,
      required this.usernameTextController,
      required this.isUsernameAvailable})
      : super(key: key);

  final TextEditingController usernameTextController;
  ValueNotifier<UsernameAvailability>? isUsernameAvailable;
  Color _isUsernameAvailableColor = Colors.white;

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  void isUsernameAvailable() {
    AccountManager(FirebaseAuth.instance)
        .checkUsernameAvailability(widget.usernameTextController.text)
        .then((value) {
      widget.isUsernameAvailable?.value = value
          ? UsernameAvailability.available
          : UsernameAvailability.unavailable;
      widget._isUsernameAvailableColor =
          widget.isUsernameAvailable?.value == UsernameAvailability.available
              ? Colors.green
              : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What should we call you?',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '@',
                style: TextStyle(
                    fontSize: 24, color: widget._isUsernameAvailableColor),
                textAlign: TextAlign.center,
              ),
              SingleLineInput(
                label: usernameLabel,
                hintText: usernameHint,
                controller: widget.usernameTextController,
                onChanged: (value) {
                  setState(() {
                    isUsernameAvailable();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum UsernameAvailability { available, unavailable, unknown }

enum RegistrationState { admin, user, registrationComplete }

enum ButtonState { enabled, disabled }

enum TextFormat { email, password, username, dateOfBirth }
