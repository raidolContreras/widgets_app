import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:in_library/config/mysql/mysql.dart';
import 'package:in_library/models/statements_models.dart';
import '/presentation/widgets/side_menu.dart';

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
  List<String> chapters = [];
  int idReglament = 0;
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getReglament();
    getChapters();
  }

  void getReglament() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    idReglament = int.parse(arguments['idReglament']!);

    db.getConnection().then((conn) {
      conn.query(StatementsModels.getReglament, [idReglament]).then((results) {
        for (var row in results) {
          setState(() {
            nameReglament = row[1].toString();
            cover = row[6].toString();
            isLoading = false;
          });
        }
      });
    });
  }

  void getChapters() {
    db.getConnection().then((conn) {
      conn.query(StatementsModels.getChapters, [idReglament]).then((results) {
        for (var row in results) {
          setState(() {
            chapters.add(row[1].toString());
            isLoading = false;
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
        title: Center(child: Text(nameReglament)),
      ),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              child: Column(
                children: [
                  FadeInDown(
                    child: DecoratedBox(
                      decoration: decoration,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          (cover != '')
                              ? 'https://app-fiscal.inscripcionesccm.online/assets/images/covers/$idReglament/$cover'
                              : 'https://publications.iarc.fr/uploads/media/default/0001/02/thumb_1244_default_publication.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  FadeInUp(
                    child: Center(
                      child: Text(
                        nameReglament,
                        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chapters.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == chapters.length) {
                          if (_isLoadingMore) {
                            return Center(child: CircularProgressIndicator());
                          }
                        } else {
                          return Text(chapters[index]);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
