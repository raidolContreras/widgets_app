import 'package:in_library/domain/datasources/article_datasource.dart';
import 'package:in_library/domain/entities/article.dart';
import 'package:in_library/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository{
  
  final ArticleDatasource datasource;

  ArticleRepositoryImpl({required this.datasource});

  @override
  Future<Article> loadArticle(int idArticle) {
    
    return datasource.loadArticle(idArticle);
    
  }

}