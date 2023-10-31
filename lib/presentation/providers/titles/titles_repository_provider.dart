
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/titlesdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/title_repository_impl.dart';

// Provider de solo lectura, es inmutable
final titleRepositoryProvider = Provider((ref) {
  return TitleRepositoryImpl(TitledbDatasource());
});