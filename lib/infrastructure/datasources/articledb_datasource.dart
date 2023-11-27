import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/article_datasource.dart';
import 'package:in_library/domain/entities/article.dart';

class ArticledbDatasource extends ArticleDatasource {
  
  final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.inscripcionesccm.online/api-fiscal/api.php',
    ));
    
  @override
  Future<Article> loadArticle(String idArticle) async {
    
    try {
      final response = await dio.get('?searchArticle=$idArticle');

      if (response.statusCode == 200) {
        return Article.fromJson(response.data);
      } else {
        throw Exception('Failed to load article data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }

  }
}