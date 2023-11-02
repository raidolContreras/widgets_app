import 'package:in_library/domain/entities/register_user.dart';
import 'package:in_library/infrastructure/models/registers/register_userdb.dart';

class RegisterUserMapper{
  static RegisterUser registerUserToEntity(RegisterUserDb registerUser ) => RegisterUser(
    message: registerUser.message
  );
}