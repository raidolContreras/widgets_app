import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/presentation/widgets/widgets.dart';
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
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: const Text('InLibrary'),
        centerTitle: true,
        actions: [
          Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
            ),
        ],
      ),
    ),
      body: const _HomeView(),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey, ),
      bottomNavigationBar: const CustomBottonNavigationBar( currentIndex: 0),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final firstMenuItem = appMenuItems.isNotEmpty ? appMenuItems.first : null;

    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          scale: 9,
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
