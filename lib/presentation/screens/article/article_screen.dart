import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/article.dart';
import 'package:in_library/presentation/providers/providers.dart';
import 'package:in_library/presentation/widgets/side_menu.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  static const name = 'article screen';
  final String idArticle;
  const ArticleScreen({
    super.key, 
    required this.idArticle
  });

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  
  final isLoggedUser = FutureProvider.family.autoDispose((ref, int isarId) {
    final localStorageRepository = ref.watch(loggedUserRepositoryProvider);
    return localStorageRepository.islogged(isarId);
  });

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ref.read(loadArticleProvider.notifier).loadArticle(widget.idArticle);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final Article articleData = ref.watch(loadArticleProvider);
    final colors = Theme.of(context).colorScheme;
    return isLoading 
      ? const Scaffold(
        body:  Center(
            child: CircularProgressIndicator(),
          ),
      ) 
      : Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(articleData.nameArticle),
          centerTitle: true,
        ),
        
        endDrawer: SideMenu(scaffoldKey: scaffoldKey, ),
        body: ListView.builder(
          itemCount: articleData.paragraphs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                articleData.paragraphs[index].paragraph ?? '',
                
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, color: colors.onSurface),
              ),
            );
          },
        ),
      );
  }
}
