
import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/title_datasource.dart';
import 'package:in_library/infrastructure/mappers/title_mapper.dart';

import 'package:in_library/domain/entities/titles.dart';
import 'package:in_library/infrastructure/models/titledb/titledb_response.dart';

class TitledbDatasource extends TitleDatasource{

    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.hucco.com.mx/api-fiscal/api.php',
    ));

  @override
  Future<List<Titles>> getTitles() async{

    final response = await dio.get('?resource=titles');
    
    final titleDBResponse = TitlesDbResponse.fromJson(response.data);

    final List<Titles> titles = titleDBResponse.result.map(
      (titledb) => TitleMapper.titleDBToEntity(titledb)
    ).toList();

    return titles;

  }

}
