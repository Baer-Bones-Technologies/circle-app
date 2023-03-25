import 'package:circle/ui/screens/authentication/login/login_mobile.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/material.dart';

/// This class is the stateful widget for the Main Home Feed Screen for Mobile.
///
/// This checks if user is logged in and if so, displays the home feed.
/// Otherwise, it displays the login screen.

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    AuthState authState = AuthenticationHandler()
        .getAuthenticationState();
    UIManager ui = UIManager(context);


    return ui.checkPlatform(
        authState: authState,
        mobile: const HomeMobile(),
        loggedOutFallbackMobile: const LoginMobile());
  }
}
