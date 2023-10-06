import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';
  
  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context){
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      content: const Text('hola mundo'),
      action: SnackBarAction(label: 'x', onPressed: (){}),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackbar
    );
  }

  void openDialog( BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Licencias utilizadas'),
        content: const Text('Culpa enim aliqua fugiat aliqua exercitation aliqua cillum excepteur culpa aute dolore cupidatat. Velit labore minim officia sit commodo enim. Proident incididunt culpa sit fugiat qui laboris Lorem aliqua proident cillum sint proident ea. Laboris enim ullamco Lorem non adipisicing cupidatat nisi nulla ea officia culpa non sint ipsum.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () => context.pop(), child: const Text('Aceptar')),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar y diálogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: (){
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Amet quis sit duis cupidatat excepteur laborum amet est aliquip consectetur consequat. Pariatur sunt commodo culpa anim cupidatat minim officia nulla id velit eiusmod voluptate exercitation exercitation. Ipsum veniam fugiat quis cupidatat et ad incididunt mollit mollit commodo exercitation aute in. Excepteur enim culpa id sunt enim. Ad veniam magna aute excepteur esse id exercitation laboris aliquip. Fugiat eu consectetur amet eu magna velit velit id exercitation duis veniam.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas')
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context), 
              child: const Text('Mostrar diálogo')
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrat Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () {
          showCustomSnackbar(context);
        },
      ),
    );
  }
}