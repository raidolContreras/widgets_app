import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: const Text('Iniciar Sesión'),
        centerTitle: true,
      ),
    ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de la aplicación
              Image.asset(
                'assets/images/logo.png', // Reemplaza con la ruta de tu logo
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 32),
              // Campos de texto
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Agregar la lógica de inicio de sesión aquí
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.onPrimary, // Color de fondo del botón
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50), // Tamaño del botón
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Botones de inicio de sesión con redes sociales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Agregar la lógica de inicio de sesión con Google aquí
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Color de fondo del botón
                      foregroundColor: Colors.black, // Color del icono
                      minimumSize: const Size(140, 50), // Tamaño del botón
                    ),
                    icon: Image.asset(
                      'assets/images/google_logo.png', // Reemplaza con la ruta del logo de Google
                      width: 24,
                      height: 24,
                    ),
                    label: const Text('Google'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Agregar la lógica de inicio de sesión con Facebook aquí
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.onPrimary, // Color de fondo del botón
                      foregroundColor: Colors.white, // Color del icono
                      minimumSize: const Size(140, 50), // Tamaño del botón
                    ),
                    icon: const Icon(Icons.facebook),
                    label: const Text('Facebook'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  // Agregar la lógica para navegar a la pantalla de registro
                },
                child: const Text('¿No tienes una cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
