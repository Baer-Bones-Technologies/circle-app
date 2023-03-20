import 'package:circle/ui/screens/home/home_mobile.dart';
import 'package:circle/ui/screens/home/home_web.dart';
import 'package:circle/ui/ui_manager.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {

    final UIManager ui = UIManager(context);

    // If the platform is web, return the web home screen.
    // Otherwise, return the mobile home screen.

    return ui.isMobile() ?  const HomeMobile() : const HomeWeb() ;
  }
}