import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/domain/entities/select_user.dart';
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

  @override
  Widget build(BuildContext context) {
    
    ref.read(userDataProvider.notifier).loadDataUser();
    final colors = Theme.of(context).colorScheme;
    final isLogged = ref.watch(isLoggedUser(1));
    
    final userData = ref.watch(userDataProvider).values.toList();

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    List<Widget> menuItems = [];

    menuItems.add( _DrawerHeader(colors: colors, isLogged: isLogged, user: userData,));

    menuItems.add(Padding(
      padding: EdgeInsets.fromLTRB(28, hasNotch ? 10 : 20, 16, 10),
      child: const Text('Menú'),
    ));

    menuItems.add(ListTile(
      leading: const Icon(
        Icons.book_outlined,
      ),
      title: Text(appMenuItems[0].title),
      subtitle: Text(appMenuItems[0].subTitle),
      onTap: () {
        context.push(appMenuItems[0].link);
        Navigator.pop(context);
      },
    ));

    menuItems.add(const Padding(
      padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
      child: Divider(),
    ));

    if (isLogged.when(
        data: (data) => data,
        loading: () => false,
        error: (error, stackTrace) => false,
      )) {

      // Nuevo botón para ir al perfil del usuario
      menuItems.add(ListTile(
        leading: const Icon(
          Icons.person,
        ),
        title: const Text('Ver perfil'),
        onTap: () {
          context.push(appMenuItems[5].link); // Reemplaza con la ruta correcta para el perfil del usuario
          Navigator.pop(context);
        },
      ));
      menuItems.add(ListTile(
        leading: Icon(
          appMenuItems[4].icon,
        ),
        title: Text(appMenuItems[4].title),
        subtitle: Text(appMenuItems[4].subTitle),
        onTap: () {
          context.push(appMenuItems[4].link);
          Navigator.pop(context);
        },
      ));
    } else {
      menuItems.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(20),
            child: ListTile(
              leading: Icon(
                appMenuItems[3].icon,
              ),
              title: Text(appMenuItems[3].title),
              onTap: () {
                context.push(appMenuItems[3].link);
                Navigator.pop(context);
              },
            ),
          ),
        )
      );
    }

    return NavigationDrawer(
      children: menuItems,
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.colors, required this.isLogged, this.user,
  });

  final ColorScheme colors;
  final AsyncValue<bool> isLogged;
  final List<SelectUser>? user;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.secondary],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('InLibrary', style: TextStyle(color: colors.onPrimary, fontSize: 24, fontWeight: FontWeight.bold),),
                    if (isLogged.when(
                        data: (data) => data,
                        loading: () => false,
                        error: (error, stackTrace) => false,
                      )) 
                      Flexible(child: Text(user![0].firstname, style: TextStyle(color: colors.onPrimary, fontSize: 18),)),
                    if (isLogged.when(
                        data: (data) => data,
                        loading: () => false,
                        error: (error, stackTrace) => false,
                      )) 
                      Flexible(child: Text(user![0].lastname, style: TextStyle(color: colors.onPrimary, fontSize: 18),)),
                    if (isLogged.when(
                        data: (data) => data,
                        loading: () => false,
                        error: (error, stackTrace) => false,
                      )) 
                      Flexible(child: Text(user![0].email, style: TextStyle(color: colors.onPrimary, fontSize: 10),)),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: colors.onPrimary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {context.push(appMenuItems[1].link); Navigator.pop(context);}, 
                icon: Icon( appMenuItems[1].icon , color: colors.primary, size: 30,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
