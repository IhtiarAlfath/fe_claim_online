import 'package:claim_online/features/authentication/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_online/initiatePage.dart';
import 'package:claim_online/features/authentication/presentation/pages/login_page.dart';
import '../../home.dart';

final GoRouter router = GoRouter(initialLocation: '/initiatePage', routes: [
  GoRoute(
    path: '/initiatePage',
    name: 'initiatePage',
    builder: (context, state) => InitiatePage(),
  ),
  GoRoute(
    path: '/login',
    name: 'loginpage',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/register',
    name: 'registerpage',
    builder: (context, state) => RegisterPage(),
  ),
  GoRoute(
    path: '/home',
    name: 'homepage',
    builder: (context, state) => HomePage(),
  ),
]);
