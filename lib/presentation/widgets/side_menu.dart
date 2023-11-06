import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/presentation/providers/providers.dart';
import '/config/menu/menus.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  final isLoggedUser = FutureProviderFamily<bool, int>((ref, isarId) {
    final localStorageRepository = ref.watch(loggedUserRepositoryProvider);
    return localStorageRepository.islogged(isarId);
  });

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Obtener el estado de autenticación del usuario (isLogged)
    final isLogged = ref.watch(isLoggedUser(1));

    // Verificar si el dispositivo tiene una "notch"
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        // Navegar a la página seleccionada
        context.push(menuItem.link);
        // Cerrar el menú lateral
        widget.scaffoldKey.currentState?.openEndDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 10 : 20, 16, 10),
          child: const Text('Menú'),
        ),
        // Mostrar los primeros elementos de menú
        ...appMenuItems.sublist(0, 1).map((item) =>
            NavigationDrawerDestination(icon: Icon(item.icon), label: Text(item.title)),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Configuraciones'),
        ),
          ...appMenuItems.sublist(1, 2).map((item) =>
            NavigationDrawerDestination(icon: Icon(item.icon), label: Text(item.title)),
          ),
        // Mostrar elementos de menú adicionales si el usuario está autenticado
        if (isLogged.when(
          data: (data) => data,
          loading: () => false,
          error: (error, stackTrace) => false,
        ))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(onPressed: () => context.go('/logout'), icon: const Icon(Icons.logout_outlined), label: const Text('Cerrar sesión')),
          )
        else
          ...appMenuItems.sublist(2, 3).map((item) =>
            NavigationDrawerDestination(icon: Icon(item.icon), label: Text(item.title)),
          ),
      ],
    );
  }
}
