import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/presentation/providers/providers.dart';
import 'package:in_library/presentation/widgets/shared/custom_botton_navigationbar.dart';
import 'package:in_library/presentation/widgets/side_menu.dart';

class ReglamentScreen extends ConsumerStatefulWidget {
  static const name = 'reglament_screen';
  final String reglamentId;

  const ReglamentScreen({required this.reglamentId, Key? key}) : super(key: key);

  @override
  ConsumerState<ReglamentScreen> createState() => _ReglamentScreenState();
}

class _ReglamentScreenState extends ConsumerState<ReglamentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ref.read(reglamentsNotifierProvider.notifier).loadReglament(widget.reglamentId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTutorial();
    });
  }

  void showTutorial() {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100.0,
        left: 100.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Desliza para navegar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );

    final context = scaffoldKey.currentContext;
    if (context != null) {
      Overlay.of(context).insert(overlayEntry);

      Future.delayed(Duration(seconds: 2)).then((_) {
        overlayEntry.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Reglament reglament = ref.watch(reglamentsNotifierProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            reglament.nameTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Elimina la sombra debajo de la AppBar
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottonNavigationBar(currentIndex: 0),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
      body: reglament.chapters.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                PageView.builder(
                  itemCount: reglament.chapters.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade600, Colors.purple.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${reglament.idTitles}/${reglament.coverName}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      final chapter = reglament.chapters[index - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chapter.nameChapter,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                letterSpacing: 1.2,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            ...chapter.sections.map((section) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.nameSection,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      letterSpacing: 1.1,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  ...section.articles.map((article) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.nameArticle,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.purple.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        ...article.paragraphs.map((paragraph) {
                                          return Text(
                                            paragraph.paragraph,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(fontSize: 16.0),
                                          );
                                        }).toList(),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }
                  },
                ),
                Positioned(
                  right: 10,
                  bottom: 0,
                  top: 0,
                  child: Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
                ),
              ],
            ),
    );
  }
}
