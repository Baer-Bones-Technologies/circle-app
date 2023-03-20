import 'package:circle/ui/screens/Home/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
  ],
);

final GoRouter router = _router;
