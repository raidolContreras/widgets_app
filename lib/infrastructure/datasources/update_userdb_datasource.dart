import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/update_user_datasource.dart';
import 'package:in_library/domain/entities/update_user.dart';
import 'package:in_library/infrastructure/mappers/update_user_mapper.dart';
import 'package:in_library/infrastructure/models/registers/update_userdb.dart';

class UpdateUserdbDatasource extends UpdateUserDatasource { 
  
    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.hucco.com.mx/api-fiscal/api.php',
    ));
  
  @override
  Future<UpdateUser> getUpdateUser(String idUser, String nameUser, String lastnameUser, String birthday, String phone) async {

    final response = await dio.get('?updateData=$idUser&firstname=$nameUser&lastname=$lastnameUser&birthday=$birthday&phone=$phone');
    if(response.statusCode != 200) throw Exception('Error al registrar, intente de nuevo');

    final updateUserDB = UpdateUserDb.fromJson(response.data);

    final UpdateUser updateUser = UpdateUserMapper.updateUserToEntity(updateUserDB);

    return updateUser;

  }
}
