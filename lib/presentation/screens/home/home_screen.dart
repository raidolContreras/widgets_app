import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/menu/menu_items.dart';
import '/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final firstMenuItem = appMenuItems.isNotEmpty ? appMenuItems.first : null;
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          Icons.library_books,
          size: 100,
          color: colors.primary,
        ),
        const SizedBox(height: 20),
        const Text(
          '¡Bienvenido a InLibrary!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Selecciona una opción para comenzar',
          style: TextStyle(fontSize: 16),
        ),
        if (firstMenuItem != null)
          _CustomListTile(menuItem: firstMenuItem),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push(menuItem.link); // Cambié 'push' a 'go' para usar GoRouter
      },
    );
  }
}
