import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponceLoginScreen extends StatelessWidget {
  static const name = 'responce_login_screen';

  final String emailUser;
  final String passwordUser;

  const ResponceLoginScreen({
    super.key,
    required this.emailUser,
    required this.passwordUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido: $emailUser'),
            TextButton.icon(
              onPressed: (){
                context.go('/');
              },
              label: const Text('Inicio'),
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ],
        ),
      ),
    );
  }
}