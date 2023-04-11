import 'package:circle/ui/screens/authentication/registration/registration_mobile.dart';
import 'package:circle/ui/screens/authentication/registration/registration_web.dart';
import 'package:circle/ui/screens/home/home.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/cupertino.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);
    AuthenticationHandler auth = AuthenticationHandler();
    return ui.checkPlatformVerbose(
        mobile: const Home(),
        web: const Home(),
        loggedOutFallbackMobile: RegistrationMobile(),
        loggedOutFallbackWeb: const RegistrationWeb(),
        authState: auth.getAuthenticationState());
  }
}
