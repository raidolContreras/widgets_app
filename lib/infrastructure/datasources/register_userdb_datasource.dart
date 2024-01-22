import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/register_user_datasource.dart';
import 'package:in_library/domain/entities/register_user.dart';
import 'package:in_library/infrastructure/mappers/register_user_mapper.dart';
import 'package:in_library/infrastructure/models/registers/register_userdb.dart';

class RegisterUserdbDatasource extends RegisterUserDatasource{
  
    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.hucco.com.mx/api-fiscal/api.php',
    ));
    
  @override
  Future<RegisterUser> getRegisterUser(String nameUser, String emailUser, String passwordUser) async {
    
    final response = await dio.get('?register=1&name=$nameUser&email=$emailUser&password=$passwordUser');
    if(response.statusCode != 200) throw Exception('Error al registrar, intente de nuevo');

    final registerUserDB = RegisterUserDb.fromJson(response.data);

    final RegisterUser registerUser = RegisterUserMapper.registerUserToEntity(registerUserDB);

    return registerUser;
  }

}