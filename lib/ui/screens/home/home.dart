import 'package:circle/ui/screens/authentication/login/login_mobile.dart';
import 'package:circle/ui/screens/authentication/login/login_web.dart';
import 'package:circle/ui/screens/home/home_mobile.dart';
import 'package:circle/ui/screens/home/home_web.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    AuthenticationHandler auth = AuthenticationHandler();

    final UIManager ui = UIManager(context);

    Widget home = ui.checkPlatformVerbose(
        authState: auth.getAuthenticationState(),
        web: const HomeWeb(),
        mobile: const HomeMobile(),
        loggedOutFallbackMobile: const LoginMobile(),
        loggedOutFallbackWeb: const LoginWeb());

    // If the platform is web, return the web home screen.
    // Otherwise, return the mobile home screen.

    return home;
  }
}
