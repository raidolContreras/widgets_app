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
    title: 'Iniciar Sesión',
    subTitle: 'Ingresa con tu correo',
    link: '/Login',
    icon: Icons.login_outlined
  ),

  MenuItem(
    title: 'Configuraciones',
    subTitle: 'Cambio de tema y modo de la',
    link: '/theme-changer',
    icon: Icons.settings_outlined
  ),

  MenuItem(
    title: 'Reglamento',
    subTitle: '',
    link: '/reglament/:idReglament',
    icon: Icons.settings_outlined
  ),

  // MenuItem(
  //   title: 'Botones',
  //   subTitle: 'Varios botones en flutter',
  //   link: '/buttons',
  //   icon: Icons.smart_button_outlined
  // ),

  // MenuItem(
  //   title: 'Contador',
  //   subTitle: 'Contador',
  //   link: '/counter',
  //   icon: Icons.add
  // ),

  // MenuItem(
  //   title: 'Tarjetas',
  //   subTitle: 'Contenedor estilizado',
  //   link: '/cards',
  //   icon: Icons.credit_card
  // ),

  // MenuItem(
  //   title: 'Progress Indicators',
  //   subTitle: 'Generales y controlados',
  //   link: '/progress',
  //   icon: Icons.refresh_rounded
  // ),

  // MenuItem(
  //   title: 'Snackbars y dialogos',
  //   subTitle: 'Indicadores en pantalla',
  //   link: '/snackbars',
  //   icon: Icons.info_outline
  // ),

  // MenuItem(
  //   title: 'Animated conteined',
  //   subTitle: 'Animaciones de contenedores',
  //   link: '/animated',
  //   icon: Icons.check_box_outline_blank_rounded
  // ),

  // MenuItem(
  //   title: 'Ui Controls + Tiles',
  //   subTitle: 'Una serie de controles de flutter',
  //   link: '/ui-controls',
  //   icon: Icons.car_rental_outlined
  // ),

  // MenuItem(
  //   title: 'Introducción a la aplicación',
  //   subTitle: 'Pequeño tutorial introductorio',
  //   link: '/tutorial',
  //   icon: Icons.accessible_rounded
  // ),

  // MenuItem(
  //   title: 'InfiniteScroll y Pull',
  //   subTitle: 'Listas infinitas y pull to refresh',
  //   link: '/infinite',
  //   icon: Icons.list_alt_rounded
  // ),
  
];