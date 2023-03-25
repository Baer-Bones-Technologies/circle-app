import 'package:circle/ui/screens/Home/home.dart';
import 'package:circle/ui/screens/authentication/registration/registration_mobile.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
    GoRoute(path: '/registration', builder: (context, state) => const RegistrationMobile())
  ],
);

final GoRouter router = _router;
