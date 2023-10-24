import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '/presentation/widgets/side_menu.dart';
import 'package:in_library/config/mysql/mysql.dart';

class ReglamentScreen extends StatefulWidget {
  static const name = 'reglament_screen';
  const ReglamentScreen({super.key});

  @override
  State<ReglamentScreen> createState() => _ReglamentScreenState();
}

class _ReglamentScreenState extends State<ReglamentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var db = MySql();
  String nameReglament = '';
  String cover = '';
  int idReglament = 0; // Agrega idReglament como variable de instancia
  bool isLoading = true; // Agrega una variable para controlar el estado de carga

  @override
  void initState() {
    super.initState();
    // No llames a getReglament() aquí
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Llama a getReglament() aquí en su lugar
    getReglament();
  }

  void getReglament() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!); //Obtiene el ID

    db.getConnection().then((conn) {
      String sql = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.idTitles = ?";
      conn.query(sql, [idReglament]).then((results) {
        for(var row in results){
          setState(() {
            nameReglament = row[1].toString(); // Convierte a cadena
            cover = row[6].toString(); // Convierte a cadena
            isLoading = false; // Establece isLoading en false cuando los datos se han cargado
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(nameReglament)), // Usa el nombre del reglamento en el título
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey), // Utiliza endDrawer en lugar de drawer
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) // Muestra el indicador de carga si isLoading es true
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            child: FadeInDown(
              child: Column(
                children: [
                  Image.network(
                    (cover != '')
                      ?'https://app-fiscal.inscripcionesccm.online/assets/images/covers/$idReglament/$cover'
                      :'https://publications.iarc.fr/uploads/media/default/0001/02/thumb_1244_default_publication.jpeg',
                  ),
                  Center(child: Text(nameReglament, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
          )
    );
  }
}
