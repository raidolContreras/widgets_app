
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/articledb_datasource.dart';
import 'package:in_library/infrastructure/repositories/article_repository_impl.dart';

// Provider de solo lectura, es inmutable
final articleRepositoryProvider = Provider((ref) {
  return ArticleRepositoryImpl(ArticledbDatasource());
});