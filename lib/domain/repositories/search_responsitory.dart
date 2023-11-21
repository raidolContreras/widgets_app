import 'package:in_library/domain/entities/search.dart';

abstract class SearchRepository {
  Future<List<Search>> searchResults(String search);
}