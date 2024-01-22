import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/search_datasource.dart';
import 'package:in_library/domain/entities/search.dart';
import 'package:in_library/infrastructure/mappers/search_mapper.dart';
import 'package:in_library/infrastructure/models/search/searchdb_responce.dart';

class SearchdbDatasource extends SearchDatasource{
  
    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.hucco.com.mx/api-fiscal/api.php',
    ));

  @override
  Future<List<Search>> searchResults(String search) async {
    
    final response = await dio.get('?search=$search');
    
    final searchDBResponse = SearchDbResponse.fromJson(response.data);

    final List<Search> searchResults = searchDBResponse.result.map(
      (searchdb) => SearchMapper.searchDBToEntity(searchdb)
    ).toList();

    return searchResults;

  }
  
}