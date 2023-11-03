import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigationBar extends StatelessWidget {
  
  final int currentIndex;

  const CustomBottonNavigationBar({super.key, required this.currentIndex});
  
  void onItemTapped(BuildContext context, int index) {
    // context.go(GoRouterState.of(context).uri.toString());
    switch(index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/Search');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Busqueda'
        ),

      ]
    );
  }
}