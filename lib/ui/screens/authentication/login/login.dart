import 'package:circle/ui/screens/authentication/login/login_web.dart';
import 'package:circle/ui/screens/authentication/login/login_mobile.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../Home/home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);
    AuthenticationHandler auth = AuthenticationHandler();
    return auth.user == null ? ui.isMobile() ? const LoginMobile() : const LoginWeb() : const Home();
  }
}
