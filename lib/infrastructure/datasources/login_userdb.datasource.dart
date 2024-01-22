
import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/login_user_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/infrastructure/mappers/login_user_mapper.dart';
import 'package:in_library/infrastructure/models/registers/select_userdb.dart';

class LoginUserdbDatasource extends LoginUserDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.hucco.com.mx/api-fiscal/api.php',
    ));

  @override
  Future<SelectUser> loginUser(String emailUser, String passwordUser) async {
    
    final response = await dio.get('?login=1&email=$emailUser&password=$passwordUser');
    if(response.statusCode != 200) throw Exception('Error al iniciar sesión, intente de nuevo');
    
    final loginUserDB = SelectUserDb.fromJson(response.data);
    
    final SelectUser registerUser = LoginUserMapper.loginUserDBToEntity(loginUserDB);

    return registerUser;

  }
  
  @override
  Future<SelectUser> dataUser({String emailUser = ''}) async {
    
    final response = await dio.get('?data=1&email=$emailUser');
    if(response.statusCode != 200) throw Exception('Error al iniciar sesión, intente de nuevo');
    
    final loginUserDB = SelectUserDb.fromJson(response.data);
    
    final SelectUser dataUser = LoginUserMapper.loginUserDBToEntity(loginUserDB);

    return dataUser;
  }
    
}