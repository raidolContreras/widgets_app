import 'package:in_library/domain/entities/update_user.dart';

abstract class UpdateUserRepository {
  Future<UpdateUser> getUpdateUser(String idUser,String nameUser,String lastnameUser,String birthday, String phone);
}