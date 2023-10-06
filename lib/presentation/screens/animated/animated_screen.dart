import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedScreen extends StatefulWidget {

  static const name = 'animated_screen';
  
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {

  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 10;

  void changeShape(){

    final random = Random();
    // Genera valores aleatorios para los componentes de color (rojo, verde y azul)
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);
    
    // Crea un nuevo color con los valores aleatorios
    final randomColor = Color.fromRGBO(red, green, blue, 1.0);
    
    width = random.nextInt(300) + 50;
    height = random.nextInt(300) + 50;

    // Asigna el nuevo color aleatorio
    color = randomColor;

    borderRadius = random.nextInt(50) + 10;
    setState(() {
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated conteiner'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.bounceOut,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}