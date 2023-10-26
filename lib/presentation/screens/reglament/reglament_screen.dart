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
  final db = MySql();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    getReglament();
    getChapters();
  }

  void getReglament() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!);

    final conn = await db.getConnection();
    final titles = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.idTitles = ?";
    final results = await conn.query(titles, [idReglament]);

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
    } else {
      setState(() {
        isLoading = false;
      });
    }
    conn.close();
  }

  void getChapters() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!);

    final conn = await db.getConnection();
    final chaptersSql = "SELECT * FROM app_chapter WHERE Title_idTitles = ?";
    final results = await conn.query(chaptersSql, [idReglament]);

    if (results.isNotEmpty) {
      for (var row in results) {
        final chapterId = row[0];
        chapters[chapterId] = {
          'idChapter': chapterId,
          'nameChapter': row[1],
        };
        getSections(chapterId);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    conn.close();
  }

  void getSections(int idChapter) async {
    final conn = await db.getConnection();
    final sectionsSql = "SELECT * FROM app_sections WHERE Chapter_idChapters = ?";
    final results = await conn.query(sectionsSql, [idChapter]);

    if (results.isNotEmpty) {
      for (var row in results) {
        final sectionId = row[0];
        sections[sectionId] = {
          'idSection': sectionId,
          'nameSection': row[1],
          'idChapter': row[2],
        };
        getArticlesSections(sectionId);
        getArticlesChapters(sectionId);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    conn.close();
  }

  void getArticlesSections(int idSection) async {
    final conn = await db.getConnection();
    final articlesSql = "SELECT * FROM app_articles WHERE Section_idSections = ?";
    final results = await conn.query(articlesSql, [idSection]);

    if (results.isNotEmpty) {
      for (var row in results) {
        final articleSectionId = row[0];
        articlesSections[articleSectionId] = {
          'idArticle': articleSectionId,
          'nameArticle': row[1],
          'idSection': row[2],
        };
        getParagraph(articleSectionId);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    conn.close();
  }

  void getArticlesChapters(int idChapter) async {
    final conn = await db.getConnection();
    final articlesSql = "SELECT * FROM app_articles WHERE Section_idSections = 0 AND Chapter_idChapters = ?";
    final results = await conn.query(articlesSql, [idChapter]);

    if (results.isNotEmpty) {
      for (var row in results) {
        final articleChapterId = row[0];
        articlesChapters[articleChapterId] = {
          'idArticle': articleChapterId,
          'nameArticle': row[1],
          'idChapter': row[3],
        };
        getParagraph(articleChapterId);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
    conn.close();
  }

  void getParagraph(int idArticle) async {
    final conn = await db.getConnection();
    final paragraphSql = "SELECT * FROM app_paragraph WHERE articles_idArticles = ? ORDER BY position ASC";
    final results = await conn.query(paragraphSql, [idArticle]);

    if (results.isNotEmpty) {
      for (var row in results) {
        final paragraphId = row[0];
        paragraph[paragraphId] = {
          'idParagraph': paragraphId,
          'paragraph': row[1],
          'idArticle': row[3],
        };
      }
    }

    setState(() {
      isLoading = false;
    });
    conn.close();
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
                Column(
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: paragraph.values
                                            .where((paragraph) =>
                                                paragraph['idArticle'] == articlesChapters[articleChapterId]['idArticle'])
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
              ],
            ),
    );
  }
}
