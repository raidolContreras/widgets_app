
import 'package:in_library/domain/entities/select_user.dart';

abstract class LoginUserRepository {
  
  Future<SelectUser> getRegisterUser(String emailUser, String passwordUser);

}