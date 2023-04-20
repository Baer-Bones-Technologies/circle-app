import 'package:circle/ui/screens/Home/home.dart';
import 'package:circle/ui/screens/authentication/login/login.dart';
import 'package:circle/ui/screens/authentication/registration/registration.dart';
import 'package:circle/ui/screens/create/create.dart';
import 'package:circle/ui/screens/explore/explore.dart';
import 'package:circle/ui/screens/notifications/notifications.dart';
import 'package:circle/ui/screens/profile/profile.dart';
import 'package:circle/utility/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child,)
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => _returnHome(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Home())),
    GoRoute(
        path: '/registration',
        builder: (context, state) => const Registration(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Registration())),
    GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Login())),
    GoRoute(
        path: '/explore',
        builder: (context, state) => const Explore(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Explore())),
    GoRoute(
        path: '/profile/:uid',
        name: 'profile',
        builder: (context, state) => Profile(uid: state.params['uid']),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: Profile(
              uid: state.params['uid'],
            ))),
    GoRoute(
        path: '/create',
        builder: (context, state) => const Create(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Create())),
    GoRoute(
        path: '/notifications',
        builder: (context, state) => const Notifications(),
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const Notifications())),
  ],
);

final GoRouter router = _router;
final ValueNotifier<int> selectedIndex = ValueNotifier(0);

Widget _returnHome() {
  Widget? home;
  AuthenticationHandler().getAuthStateStream().listen((event) {
    switch (event) {
      case AuthState.loggedIn:
        home = const Home();
        break;
      default:
        home = const Login();
    }
  });
  if (home != null) {
    return home!;
  } else {
    return const Center(child: Login());
  }
}
