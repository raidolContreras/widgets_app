import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/searchdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/search_repository_impl.dart';

// Provider de solo lectura, es inmutable
final searchRepositoryProvider = Provider((ref) {
  return SearchRepositoryImpl(SearchdbDatasource());
});