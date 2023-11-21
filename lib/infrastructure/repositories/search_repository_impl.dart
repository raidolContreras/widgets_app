import 'package:in_library/domain/datasources/search_datasource.dart';
import 'package:in_library/domain/entities/search.dart';
import 'package:in_library/domain/repositories/search_responsitory.dart';

class SearchRepositoryImpl extends SearchRepository{
  final SearchDatasource datasource;

  SearchRepositoryImpl(
    this.datasource
  );

  @override
  Future<List<Search>> searchResults(String search) {
    return datasource.searchResults(search);
  }

}