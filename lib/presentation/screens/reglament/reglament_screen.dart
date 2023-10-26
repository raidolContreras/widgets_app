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
  int idReglament = 0;
  String cover = '';
  Map reglament = {};
  Map chapters = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getReglament();
    getChapters(); // Llama a la función para cargar los capítulos
  }

  void getReglament() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!); // Obtiene el ID

    db.getConnection().then((conn) {
      String titles = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.idTitles = ?";
      conn.query(titles, [idReglament]).then((results) {
        if (results.isNotEmpty) {
          final row = results.first;
          setState(() {
            cover = row[6].toString();
            reglament = {
              'id': row[0],
              'nombre': row[1].toString(),
              'cover': (row[3] != null)
                  ? 'https://app-fiscal.inscripcionesccm.online/assets/images/covers/$idReglament/$cover'
                  : 'https://publications.iarc.fr/uploads/media/default/0001/02/thumb_1244_default_publication.jpeg',
            };
            isLoading = false;
          });
        }
      });
    });
  }

  void getChapters() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!); // Obtiene el ID

    db.getConnection().then((conn) {
      String chaptersSql = "SELECT * FROM app_chapter WHERE Title_idTitles = ?";
      conn.query(chaptersSql, [idReglament]).then((results) {
        for (var row in results) {
          setState(() {
            chapters[row[0]] = {
              'idChapter': row[0],
              'nameChapter': row[1],
            };
          });
 
        }
        print('data $chapters');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: Offset(0, 10),
        )
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(
            child: FadeIn(
                duration: const Duration(milliseconds: 200),
                child: Text(reglament['nombre'] ?? ''))),
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                  child: Column(
                    children: [
                      FadeInDown(
                        duration: const Duration(seconds: 1),
                        child: DecoratedBox(
                          decoration: decoration,
                          child: SizedBox(
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                reglament['cover'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FadeInUp(
                        child: Center(
                          child: Text(
                            reglament['nombre'],
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: chapters.length,
                        itemBuilder: (BuildContext context, int index) {
                          final chapter = chapters[index + 1];
                          return Center(
                            child: Text(chapter['nameChapter'].toString(), // Convierte a cadena de texto
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            )

    );
  }
}
