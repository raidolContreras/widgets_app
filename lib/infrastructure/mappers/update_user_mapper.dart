import 'package:in_library/domain/entities/update_user.dart';
import 'package:in_library/infrastructure/models/registers/update_userdb.dart';

class UpdateUserMapper{
  static UpdateUser updateUserToEntity(UpdateUserDb updateUser ) => UpdateUser(message: updateUser.message);
}