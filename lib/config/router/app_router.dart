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
      routes: [
        GoRoute(
          path: 'Login',
          name: LoginScreen.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: 'updateData/:idUser/:nameUser/:lastnameUser/:birthdayUser/:phoneUser',
          name: UpdateDataScreen.name,
          builder: (context, state) {
            final String idUser = state.pathParameters['idUser'] ?? '';
            final String nameUser = state.pathParameters['nameUser'] ?? '';
            final String lastnameUser = state.pathParameters['lastnameUser'] ?? '';
            final String birthdayUser = state.pathParameters['birthdayUser'] ?? '';
            final String phoneUser = state.pathParameters['phoneUser'] ?? '';

            return UpdateDataScreen(idUser: idUser, nameUser: nameUser, lastnameUser: lastnameUser, birthdayUser: birthdayUser, phoneUser: phoneUser);
          },
        ),
      ]
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
      path: '/Reglament/:idReglament',
      name: ReglamentScreen.name,
      builder: (context, state)  {
        final String idReglament = state.pathParameters['idReglament'] ?? 'sin-id';
        return ReglamentScreen(reglamentId: idReglament,);
      },
    ),

    GoRoute(
      path: '/Register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/SendRegister/:nameUser/:emailUser/:passwordUser',
      name: SendRegisterScreen.name,
      builder: (context, state) {

        final nameUser = state.pathParameters['nameUser'] ?? 'sin-nombre';
        final emailUser = state.pathParameters['emailUser'] ?? 'sin-email';
        final passwordUser = state.pathParameters['passwordUser'] ?? 'sin-password';

        return  SendRegisterScreen(nameUser: nameUser, emailUser: emailUser, passwordUser: passwordUser,);
      },
    ),

    GoRoute(
      path: '/ResponceLogin/:emailUser/:passwordUser',
      name: ResponceLoginScreen.name,
      builder: (context, state) {

        final emailUser = state.pathParameters['emailUser'] ?? 'sin-email';
        final passwordUser = state.pathParameters['passwordUser'] ?? 'sin-password';

        return  ResponceLoginScreen(emailUser: emailUser, passwordUser: passwordUser,);
      },
    ),
    
    GoRoute(
      path: '/Logout',
      name: LogoutScreen.name,
      builder: (context, state) => const LogoutScreen(),
    ),

    GoRoute(
      path: '/Profile',
      name: ProfileScreen.name,
      builder: (context, state) => const ProfileScreen(),
    ),

    GoRoute(
      path: '/Search',
      name: SearchScreen.name,
      builder: (context, state) => const SearchScreen(),
    ),

    GoRoute(
      path: '/Article/:idArticle',
      name: ArticleScreen.name,
      builder: (context, state) {
        
        final idArticle = state.pathParameters['idArticle'] ?? 'sin-email';
        return ArticleScreen(idArticle: idArticle);
      },
    ),

    GoRoute(
      path: '/Favorites/:userId',
      name: FavoritesScreen.name,
      builder: (context, state) {
        
        final String userId = state.pathParameters['userId'] ?? '';
        return FavoritesScreen(userId: userId);

      },
    ),
  ],
);