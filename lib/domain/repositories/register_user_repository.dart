import 'package:in_library/domain/entities/register_user.dart';

abstract class RegisterUserRepository {
  Future<RegisterUser> getRegisterUser(String nameUser, String emailUser, String passwordUser);
}