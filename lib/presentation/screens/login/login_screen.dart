import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  
  static const name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
    );
  }
}