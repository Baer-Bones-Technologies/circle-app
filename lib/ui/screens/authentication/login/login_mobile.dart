import 'package:circle/resources/strings.dart';
import 'package:circle/resources/theme.dart';
import 'package:circle/ui/common/common_ui.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:circle/utility/security/password.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  @override
  Widget build(BuildContext context) {
    TextInputType inputType = TextInputType.emailAddress;
    TextInputType passwordType = TextInputType.visiblePassword;
    TextEditingController emailController = TextEditingController(text: "");
    TextEditingController passwordController = TextEditingController(text: "");
    Size screen = UIManager(context).getScreenSize();
    ValueNotifier<bool> isError = ValueNotifier(false);
    ValueNotifier<String> errorMessage = ValueNotifier("");
    Password? pass;

    return Scaffold(
        backgroundColor: CircleTheme.primary.value,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screen.height,
            width: screen.width,
            child: Center(
              child: SizedBox(
                width: screen.width * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Logo(),
                    const SizedBox(height: 100),
                    const Text(welcomeMessage,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                        textAlign: TextAlign.start),
                    const SizedBox(height: 20),
                    Visibility(
                        visible: isError.value,
                        child: Text(errorMessage.value,
                            style: const TextStyle(color: Colors.redAccent))),
                    SingleLineInput(
                      controller: emailController,
                      keyboardType: inputType,
                      label: emailLabel,
                      hintText: 'john.doe@example.com',
                    ),
                    const SizedBox(height: 20),
                    SingleLineInput(
                      controller: passwordController,
                      keyboardType: passwordType,
                      label: passwordLabel,
                      hintText: '********',
                      obscureText: true,
                      onChanged: (value) {
                        pass = Password(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () => context.go('/registration'),
                            child: const Text(
                              'Register for Circle',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(width: 100),
                        PrimaryButton(
                          onPressed: () {
                            if (emailController.value.text.isNotEmpty &&
                                pass != null) {
                              AuthenticationHandler()
                                  .signInWithEmailAndPassword(
                                      emailController.value.text, pass!)
                                  .then((value) {
                                if (value != null) {
                                  context.go('/');
                                } else {
                                  isError.value = true;
                                  errorMessage.value = noUserError;
                                }
                              }).catchError((error){
                                isError.value = true;
                                errorMessage.value = error.message;
                              });
                              if (kDebugMode) {
                                print("${emailController.text} logging in");
                              }
                            } else {
                              if (kDebugMode) {
                                isError.value = true;
                                errorMessage.value = "input value empty";
                              }
                            }
                          },
                          text: loginLabel,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
