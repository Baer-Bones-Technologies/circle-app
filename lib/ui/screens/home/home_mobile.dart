import 'package:circle/ui/ui_manager.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/material.dart';

import '../../../navigation/mobile_navigation/navbar.dart';

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

  final AuthState _authState = AuthenticationHandler()
    .getAuthenticationState();

  @override
  Widget build(BuildContext context) {
    UIManager ui = UIManager(context);

    return const Scaffold(
      body: SafeArea(child: Placeholder()),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
