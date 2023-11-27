import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/presentation/providers/providers.dart';
import 'package:in_library/presentation/widgets/shared/custom_botton_navigationbar.dart';
import 'package:in_library/presentation/widgets/side_menu.dart';
import 'package:in_library/presentation/widgets/reglaments/reglaments.dart';

class ReglamentScreen extends ConsumerStatefulWidget {
  static const name = 'reglament_screen';
  final String reglamentId;

  const ReglamentScreen({super.key, required this.reglamentId});

  @override
  ConsumerState<ReglamentScreen> createState() => _ReglamentScreenState();
}

class _ReglamentScreenState extends ConsumerState<ReglamentScreen> {
  
  final isLoggedUser = FutureProvider.family.autoDispose((ref, int isarId) {
    final localStorageRepository = ref.watch(loggedUserRepositoryProvider);
    return localStorageRepository.islogged(isarId);
  });

  bool isLoading = true;

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
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
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
    
    final isLogged = ref.watch(isLoggedUser(1));

    return isLoading 
      ? const Scaffold(
        body:  Center(
            child: CircularProgressIndicator(),
          ),
      ) 
    : Scaffold(
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
                      return PortrateWidget(colors: colors, reglament: reglament);
                    } else {
                      final chapter = reglament.chapters[index - 1];
                      return ChapterWidget(chapter: chapter, colors: colors, hashCode: hashCode, isLogged: isLogged);
                    }
                  },
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FooterButtons(canGoBack: _canGoBack, colors: colors, pageController: _pageController, canGoForward: _canGoForward),
    );
  }
}

