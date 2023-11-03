
import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/login_user_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/infrastructure/mappers/login_user_mapper.dart';
import 'package:in_library/infrastructure/models/registers/login_user_result.dart';

class LoginUserdbDatasource extends LoginUserDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.inscripcionesccm.online/api-fiscal/api.php',
    ));

  @override
  Future<SelectUser> loginUser(String emailUser, String passwordUser) async {
    
    final response = await dio.get('?login=1&email=$emailUser&password=$passwordUser');
    if(response.statusCode != 200) throw Exception('Error al iniciar sesión, intente de nuevo');
    
    final loginUserDB = LoginUserResult.fromJson(response.data);
    
    final SelectUser registerUser = LoginUserMapper.loginUserDBToEntity(loginUserDB);

    return registerUser;
    

  }
    
}