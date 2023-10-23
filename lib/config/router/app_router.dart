import 'package:go_router/go_router.dart';
import '/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/theme-changer',
      name: ThemeChangerScreen.name,
      builder: (context, state) => const ThemeChangerScreen(),
    ),

    GoRoute(
      path: '/Reglaments',
      name: ReglamentsScreen.name,
      builder: (context, state) => const ReglamentsScreen(),
    ),

    GoRoute(
      path: '/Login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);