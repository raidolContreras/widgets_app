import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const name = 'profile_screen';
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mi Perfil'),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Implementar la lógica de edición aquí
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Nombre'),
                subtitle: Text('John Doe'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Correo Electrónico'),
                subtitle: Text('johndoe@example.com'),
              ),
              // Otros campos editables aquí
              ElevatedButton(
                onPressed: () {
                  // Implementar la lógica para guardar cambios
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
