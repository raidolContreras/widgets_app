import 'package:flutter/material.dart';


class ReglamentsScreen extends StatelessWidget {
  static const name = 'reglaments_screen';
  const ReglamentsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reglamentos'),
      ),
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
