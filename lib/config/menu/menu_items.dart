import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon
  });
}

const appMenuItems = <MenuItem>[

  MenuItem(
    title: 'Reglamentos',
    subTitle: 'Ingresa a ver los reglamentos',
    link: '/Reglaments',
    icon: Icons.book_outlined
  ),

  MenuItem(
    title: 'Temas',
    subTitle: 'Cambio de tema y modo de la',
    link: '/theme-changer',
    icon: Icons.color_lens_outlined
  ),

  MenuItem(
    title: 'Reglamento',
    subTitle: 'Lee todo el reglamento',
    link: '/reglament/:idReglament',
    icon: Icons.book_online_outlined
  ),

  MenuItem(
    title: 'Iniciar Sesión',
    subTitle: 'Ingresa con tu correo',
    link: '/Login',
    icon: Icons.login_outlined
  ),

  MenuItem(
    title: 'Cerrar Sesión',
    subTitle: 'Salir del sistema',
    link: '/Logout',
    icon: Icons.logout_outlined
  ),
  
];