import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/reglaments_datasource.dart';
import 'package:in_library/domain/entities/reglaments.dart';

class ReglamentsDbDatasource extends ReglamentsDatasource {
  final Dio _dio;

  ReglamentsDbDatasource({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<Reglament> getReglament(String reglamentId) async {
    try {
      final response = await _dio.get('/api-fiscal/api.php?reglament=$reglamentId');

      if (response.statusCode == 200) {
        return Reglament.fromJson(response.data);
      } else {
        throw Exception('Failed to load reglament data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }
}
