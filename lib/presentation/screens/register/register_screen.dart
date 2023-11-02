import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  static const name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _acceptTerms = false;
  bool _isButtonEnabled = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void updateButtonState() {
    setState(() {
      _isButtonEnabled = _acceptTerms &&
          nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Registro de Usuario'),
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
              // Campo de texto para el nombre
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (_) => updateButtonState(),
              ),
              const SizedBox(height: 16),
              // Campo de texto para el correo electrónico
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (_) => updateButtonState(),
              ),
              const SizedBox(height: 16),
              // Campo de texto para la contraseña
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (_) => updateButtonState(),
              ),
              const SizedBox(height: 16),
              // Casilla de "Aceptar Términos y Condiciones"
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                        updateButtonState();
                      });
                    },
                  ),
                  const Text('Aceptar Términos y Condiciones'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isButtonEnabled ? () {
                  context.go('/SendRegister/${nameController.text}/${emailController.text}/${passwordController.text}');
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary, // Color de fondo del botón
                  foregroundColor: colors.onPrimary,
                  minimumSize: const Size(200, 50), // Tamaño del botón
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                 context.go('/login');
                },
                child: const Text('¿Ya tienes una cuenta? Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
