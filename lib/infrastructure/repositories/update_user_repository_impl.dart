import 'package:in_library/domain/datasources/update_user_datasource.dart';
import 'package:in_library/domain/entities/update_user.dart';
import 'package:in_library/domain/repositories/update_user_repository.dart';

class UpdateUserRepositoryImpl extends UpdateUserRepository {  

  final UpdateUserDatasource datasource;

  UpdateUserRepositoryImpl(
    this.datasource
  );
  
  @override
  Future<UpdateUser> getUpdateUser(String idUser, String nameUser, String lastnameUser, String birthday, String phone) {
    return datasource.getUpdateUser(idUser, nameUser, lastnameUser, birthday, phone);
  }
}
