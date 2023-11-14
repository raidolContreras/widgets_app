import 'package:animate_do/animate_do.dart';
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
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentPage = 0;
  bool _canGoBack = false;
  bool _canGoForward = true;

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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              'Desliza para navegar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );

    final context = scaffoldKey.currentContext;
    if (context != null) {
      Overlay.of(context).insert(overlayEntry);

      Future.delayed(const Duration(seconds: 2)).then((_) {
        overlayEntry.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Reglament reglament = ref.watch(reglamentsNotifierProvider);
    final colors = Theme.of(context).colorScheme;

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
              color: colors.onBackground,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: colors.background,
              boxShadow: [
                BoxShadow(
                  color: colors.onBackground.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottonNavigationBar(currentIndex: 0),
      endDrawer: SideMenu(scaffoldKey: scaffoldKey),
      body: reglament.chapters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(), // Deshabilita el deslizamiento
                  itemCount: reglament.chapters.length + 1,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                      _canGoBack = index > 0;
                      _canGoForward = index < reglament.chapters.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: 'cover_image',
                            child: Image.network(
                              'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${reglament.idTitles}/${reglament.coverName}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    } else {
                      final chapter = reglament.chapters[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12.0),
                                Hero(
                                  tag: 'chapter_title_$index',
                                  child: Text(
                                    chapter.nameChapter,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      letterSpacing: 1.2,
                                      color: colors.onBackground,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                ...chapter.sections.map((section) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: 'section_title_${section.hashCode}',
                                        child: Text(
                                          section.nameSection,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            letterSpacing: 1.1,
                                            color: colors.onBackground,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      ...section.articles.map((article) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: 'article_title_${article.hashCode}',
                                              child: Text(
                                                article.nameArticle,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                  color: colors.onBackground,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            ...article.paragraphs.map((paragraph) {
                                              return FadeIn(
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                                  padding: const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: colors.surface,
                                                  ),
                                                  child: Text(
                                                    paragraph.paragraph,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(fontSize: 16.0, color: colors.onSurface),
                                                  ),
                                                ),
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
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: _canGoBack ? colors.onBackground : colors.onSurface.withOpacity(0.5)),
                onPressed: _canGoBack
                    ? () {
                        _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: _canGoForward ? colors.onBackground : colors.onSurface.withOpacity(0.5)),
                onPressed: _canGoForward
                    ? () {
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}