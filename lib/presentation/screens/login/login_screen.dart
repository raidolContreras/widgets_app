import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  
  static const name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Iniciar Sesión')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 80),
              BounceInDown(
                child: ElevatedButton(
                  onPressed: () {
                    // Agregar la lógica de inicio de sesión aquí
                  },
                  child: const Text('Iniciar Sesión'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BounceInLeft(
                    child: ElevatedButton(
                      onPressed: () {
                        // Agregar la lógica de inicio de sesión con Google aquí
                      },
                      child: const Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  const SizedBox(width: 16),
                  BounceInRight(
                    child: ElevatedButton(
                      onPressed: () {
                        // Agregar la lógica de inicio de sesión con Facebook aquí
                      },
                      child: const Text('f', style: TextStyle(fontSize: 24, fontFamily: 'Hind', fontWeight: FontWeight.bold),),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
