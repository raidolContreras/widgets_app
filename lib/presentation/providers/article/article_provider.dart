
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/article.dart';
import 'package:in_library/presentation/providers/article/article_repository_provider.dart';

final loadArticleProvider = StateNotifierProvider<ArticleNotifier, Article>((ref) {
  final fetchArticle = ref.watch(articleRepositoryProvider).loadArticle;
  final initialArticle = Article(idArticle: 0, nameArticle: '', paragraphs: []);
  
  return ArticleNotifier(
    initialArticle,
    fetchArticle,
  );
});
typedef ArticleCallback = Future<Article> Function(String);

class ArticleNotifier extends StateNotifier<Article> {
  ArticleCallback fetchArticle;
  
  ArticleNotifier(
    super.state,
    this.fetchArticle
  );

  Future<void> loadArticle(String articleId) async {
    final Article article = await fetchArticle(articleId);
    state = article;
  }

}