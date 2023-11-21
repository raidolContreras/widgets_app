import 'package:in_library/infrastructure/models/search/search_searchdb.dart';

class SearchDbResponse {
  
  final List<SearchSearchDB> result;

  SearchDbResponse({
    required this.result
  }); // Cambio a List

  
  factory SearchDbResponse.fromJson(Map<String, dynamic> json) => SearchDbResponse(
        result: (json['results'] as List<dynamic>)
            .map((item) => SearchSearchDB.fromJson(item))
            .toList(),
  );

}