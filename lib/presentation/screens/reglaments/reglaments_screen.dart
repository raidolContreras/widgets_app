import 'package:flutter/material.dart';
import '/presentation/widgets/side_menu.dart';


class ReglamentsScreen extends StatelessWidget {
  static const name = 'reglaments_screen';
  const ReglamentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Reglamentos'),
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey), // Utiliza endDrawer en lugar de drawer
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Agrega aquí la funcionalidad para la opción 1
              },
              child: const Text('Opción 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Agrega aquí la funcionalidad para la opción 2
              },
              child: const Text('Opción 2'),
            ),
          ],
        ),
      ),
    );
  }
}
