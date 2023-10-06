import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar y diálogos'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Mostrat Snackbar'),
        icon: Icon(Icons.remove_red_eye_outlined),
        onPressed: () {
          showCustomSnackbar(context);
        },
      ),
    );
  }
}