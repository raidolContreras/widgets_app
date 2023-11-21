import 'package:in_library/domain/entities/search.dart';

abstract class SearchDatasource {
  Future<List<Search>> searchResults(String search);
}