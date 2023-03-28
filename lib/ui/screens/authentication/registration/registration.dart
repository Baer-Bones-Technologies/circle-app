import 'package:circle/ui/screens/authentication/registration/registration_mobile.dart';
import 'package:circle/ui/screens/authentication/registration/registration_web.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/cupertino.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);
    return ui.checkPlatform(
        mobile: RegistrationMobile(),
        web: const RegistrationWeb());
  }
}
