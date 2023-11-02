import 'package:flutter/material.dart';

class SendRegisterScreen extends StatelessWidget {
  static const name = 'send_register_screen';
  final String nameUser;
  final String emailUser;
  final String passwordUser;
  const SendRegisterScreen({
    super.key,
    required this.nameUser,
    required this.emailUser,
    required this.passwordUser
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrando a: $emailUser',style: const TextStyle(fontSize: 14),),
      ),
    );
  }
}