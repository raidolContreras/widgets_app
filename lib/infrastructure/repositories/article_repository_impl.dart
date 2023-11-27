import 'package:in_library/domain/datasources/article_datasource.dart';
import 'package:in_library/domain/entities/article.dart';
import 'package:in_library/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository{
  
  final ArticleDatasource datasource;

  ArticleRepositoryImpl(this.datasource);

  @override
  Future<Article> loadArticle(String idArticle) {
    
    return datasource.loadArticle(idArticle);
    
  }

}