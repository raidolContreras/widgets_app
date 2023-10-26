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
  Map sections = {};
  Map articlesSections = {};
  Map articlesChapters = {};
  Map paragraph = {};
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
    getChapters();
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
          });
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
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
        if (results.isNotEmpty) {
          for (var row in results) {
            setState(() {
              isLoading = true;
              chapters[row[0]] = {
                'idChapter': row[0],
                'nameChapter': row[1],
              };
              getSections(row[0]);
            });
          }
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }
      });
    });
  }

  void getSections(int idChapter) {
    db.getConnection().then((conn) {
      String sectionsSql = "SELECT * FROM app_sections WHERE Chapter_idChapters = ?";
      conn.query(sectionsSql, [idChapter]).then((results) {
        if (results.isNotEmpty) {
          for (var row in results) {
            setState(() {
              isLoading = true;
              sections[row[0]] = {
                'idSection': row[0],
                'nameSection': row[1], // Actualiza el índice si es diferente en tu base de datos
                'idChapter': row[2], // Actualiza el índice si es diferente en tu base de datos
              };
              getArticlesSections(row[0]);
              getArticlesChapters(row[0]);
            });
          }
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }
      });
    });
  }

  void getArticlesSections(int idSection) {
    db.getConnection().then((conn) {
      String articlesSql = "SELECT * FROM app_articles WHERE Section_idSections = ?";
      conn.query(articlesSql, [idSection]).then((results) {
        if (results.isNotEmpty) {
          for (var row in results) {
            setState(() {
              isLoading = true;
              articlesSections[row[0]] = {
                'idArticle': row[0],
                'nameArticle': row[1],
                'idSection': row[2],
              };
              getParagraph(row[0]);
            });
          }
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }
      });
    });
  }

  void getArticlesChapters(int idChapter) {
    db.getConnection().then((conn) {
      String articlesSql = "SELECT * FROM app_articles WHERE Section_idSections = 0 AND Chapter_idChapters = ?";
      conn.query(articlesSql, [idChapter]).then((results) {
        if (results.isNotEmpty) {
          for (var row in results) {
            setState(() {
              isLoading = true;
              articlesChapters[row[0]] = {
                'idArticle': row[0],
                'nameArticle': row[1],
                'idChapter': row[3],
              };
              getParagraph(row[0]);
            });
          }
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }
      });
    });
  }

  void getParagraph(int idArticle) {
    db.getConnection().then((conn) {
      String paragraphSql = "SELECT * FROM app_paragraph WHERE articles_idArticles = ? ORDER BY position ASC";
      conn.query(paragraphSql, [idArticle]).then((results) {
        if (results.isNotEmpty) {
          for (var row in results) {
            setState(() {
              isLoading = true;
              paragraph[row[0]] = {
                'idParagraph': row[0],
                'paragraph': row[1],
                'idArticle': row[3],
              };
            });
          }
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }else {
          setState(() {
            isLoading = false; // Marca isLoading como falso solo si hay contenido
          });
        }
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
        child: Text(reglament['nombre'] ?? ''),
      ),
    ),
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  for (var chapterId in chapters.keys) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapters[chapterId]['nameChapter'].toString(),
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          for (var sectionId in sections.keys
                              .where((sectionId) => sections[sectionId]['idChapter'] == chapterId))
                            ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sections[sectionId]['nameSection'].toString(),
                                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                                  ),
                                  for (var articleSectionId in articlesSections.keys
                                      .where((articleSectionId) => articlesSections[articleSectionId]['idSection'] == sectionId))
                                    ...[
                                      Column(
                                        children: [
                                          Text(
                                            '${articlesSections[articleSectionId]['nameArticle'].toString()}:',
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: paragraph.values
                                              .where((paragraph) =>
                                                  paragraph['idArticle'] == articleSectionId)
                                              .map((paragraph) => Text(
                                                    paragraph['paragraph'].toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16, fontWeight: FontWeight.normal),
                                                    textAlign: TextAlign.justify,
                                                  ))
                                              .toList(),
                                          )
                                        ],
                                      ),
                                    ],
                                ],
                              ),
                            ],
                          const Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Divider(),
                          ),
                          // Agrega los artículos de los capítulos
                          for (var articleChapterId in articlesChapters.keys
                              .where((articleChapterId) => articlesChapters[articleChapterId]['idChapter'] == chapterId))
                            ...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${articlesChapters[articleChapterId]['nameArticle'].toString()}:',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          const Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
);

  }}