import 'package:circle/ui/screens/Home/home.dart';
import 'package:circle/ui/screens/authentication/registration/registration_mobile.dart';
import 'package:circle/ui/screens/create/create.dart';
import 'package:circle/ui/screens/explore/explore.dart';
import 'package:circle/ui/screens/notifications/notifications.dart';
import 'package:circle/ui/screens/profile/Profile.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:circle/ui/screens/authentication/login/login.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => _returnHome()),
    GoRoute(path: '/registration', builder: (context, state) => RegistrationMobile()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/explore', builder: (context, state) => const Explore()),
    GoRoute(path: '/profile', builder: (context, state) => const Profile()),
    GoRoute(path: '/create', builder: (context, state) => const Create()),
    GoRoute(path: '/notifications', builder: (context, state) => const Notifications()),
  ],
);

final GoRouter router = _router;

Widget _returnHome(){
  Widget? home;
  AuthenticationHandler().getAuthStateStream().listen((event) {
    switch(event){
      case AuthState.loggedIn:
        home = const Home();
        break;
      default:
        home =  const Login();
    }
  });
  if(home != null){
    return home!;
  }else{
    return const Center(child: Login());
  }
}