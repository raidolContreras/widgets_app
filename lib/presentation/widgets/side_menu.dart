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
  
  final isLoggedUser = FutureProvider.family.autoDispose((ref, int isarId) {
    final localStorageRepository = ref.watch(loggedUserRepositoryProvider);
    return localStorageRepository.islogged(isarId);
  });

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    MenuItem menuItem = appMenuItems[navDrawerIndex];
    final isLogged = ref.watch(isLoggedUser(1));
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    List<Widget> menuItems = [];

    menuItems.add( DrawerHeader(
      decoration: BoxDecoration(
        color: colors.primary
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('InLibrary', textAlign: TextAlign.right, style: TextStyle(color: colors.onPrimary),),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () => context.push(appMenuItems[1].link), icon: Icon( appMenuItems[1].icon , color: colors.onPrimary),),
              ],
            ),
          ],
        ),
      ),
    ));

    menuItems.add(Padding(
      padding: EdgeInsets.fromLTRB(28, hasNotch ? 10 : 20, 16, 10),
      child: const Text('Menú'),
    ));

    menuItems.add(ListTile(
      leading: const Icon(
        Icons.book_outlined,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push(menuItem.link);
      },
    ));

    menuItems.add(const Padding(
      padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
      child: Divider(),
    ));

    for (var i = 1; i < appMenuItems.length; i++) {
      if (isLogged.when(
            data: (data) => data,
            loading: () => false,
            error: (error, stackTrace) => false,
          )) {
        if (appMenuItems[i].title != 'Iniciar Sesión' && appMenuItems[i].title != 'Reglamento' && appMenuItems[i].title != 'Temas') {
          menuItems.add(ListTile(
            leading: Icon(
              appMenuItems[i].icon,
            ),
            title: Text(appMenuItems[i].title),
            subtitle: Text(appMenuItems[i].subTitle),
            onTap: () {
              context.push(appMenuItems[i].link);
            },
          ));
        }
      } else {
        if (appMenuItems[i].title != 'Cerrar Sesión' && appMenuItems[i].title != 'Reglamento' && appMenuItems[i].title != 'Temas') {
          menuItems.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  child: ListTile(
                    leading: Icon(
                      appMenuItems[i].icon,
                    ),
                    title: Text(appMenuItems[i].title),
                    onTap: () {
                      context.push(appMenuItems[i].link);
                    },
                  ),
                ),
              )
          );
        }
      }
    }

    return NavigationDrawer(
      children: menuItems,
    );
  }
}
