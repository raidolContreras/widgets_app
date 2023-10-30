
import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/title_datasource.dart';
import 'package:in_library/domain/entities/titles.dart';

class TitledbDatasource extends TitleDatasource{

    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.inscripcionesccm.online/api-fiscal/api.php',
    ));

  @override
  Future<List<Titles>> getTitles() async{

    final response = await dio.get('?resource=titles');

    final List<Titles> titles = [];

    
    return titles;

  }
  
}
