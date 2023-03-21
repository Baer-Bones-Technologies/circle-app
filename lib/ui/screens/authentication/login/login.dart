import 'package:circle/ui/screens/authentication/login/login_web.dart';
import 'package:circle/ui/screens/authentication/login/login_mobile.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);
    return ui.isMobile() ? const LoginMobile() : const LoginWeb();
  }
}
