import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Si alguno de los campos está vacío, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los campos de correo y contraseña no pueden estar vacíos.'),
        ),
      );
    } else {
      // Agregar la lógica de inicio de sesión aquí
    }
  }

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
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Image.asset(
                  'assets/images/logo.png', // Reemplaza con la ruta de tu logo
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 32),
              // Campo de texto para el correo electrónico
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Campo de texto para la contraseña
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Casilla de "Recuérdame"
              FadeInRight(
                delay: const Duration(milliseconds: 550),
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text('Recuérdame'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FadeInDown(
                delay: const Duration(milliseconds: 650),
                child: ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary, // Color de fondo del botón
                    foregroundColor: colors.onPrimary,
                    minimumSize: const Size(200, 50), // Tamaño del botón
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Botones de inicio de sesión con redes sociales
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () {
              //         // Agregar la lógica de inicio de sesión con Google aquí
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white, // Color de fondo del botón
              //         foregroundColor: Colors.black, // Color del icono
              //         minimumSize: const Size(140, 50), // Tamaño del botón
              //       ),
              //       icon: Image.asset(
              //         'assets/images/google_logo.png', // Reemplaza con la ruta del logo de Google
              //         width: 24,
              //         height: 24,
              //       ),
              //       label: const Text('Google'),
              //     ),
              //     const SizedBox(width: 16),
              //     ElevatedButton.icon(
              //       onPressed: () {
              //         // Agregar la lógica de inicio de sesión con Facebook aquí
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: colors.primary, // Color de fondo del botón
              //         foregroundColor: colors.onPrimary, // Color del icono
              //         minimumSize: const Size(140, 50), // Tamaño del botón
              //       ),
              //       icon: const Icon(Icons.facebook),
              //       label: const Text('Facebook'),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: TextButton(
                  onPressed: () {
                    context.push('/Register');
                  },
                  child: const Text('¿No tienes una cuenta? Regístrate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
