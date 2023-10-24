import 'package:flutter/material.dart';
import '/presentation/widgets/side_menu.dart';

class ReglamentScreen extends StatefulWidget {
  static const name = 'reglament_screen';
  const ReglamentScreen({super.key});

  @override
  State<ReglamentScreen> createState() => _ReglamentScreenState();
}

class _ReglamentScreenState extends State<ReglamentScreen> {
  @override
  Widget build(BuildContext context) {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  final idReglament = int.parse(arguments['idReglament']!); // Obtiene el ID

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Reglamento $idReglament')), // Usa el ID en el título
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey), // Utiliza endDrawer en lugar de drawer
      body: const SafeArea(child: Text('hola'),)
    );
  }
}
