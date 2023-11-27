import 'package:in_library/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Article> loadArticle(String idArticle);
}