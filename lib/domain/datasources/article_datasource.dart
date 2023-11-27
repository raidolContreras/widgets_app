import 'package:in_library/domain/entities/article.dart';

abstract class ArticleDatasource {
  Future<Article> loadArticle(int idArticle);
}