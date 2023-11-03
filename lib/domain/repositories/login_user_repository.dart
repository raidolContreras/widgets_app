
import 'package:in_library/domain/entities/select_user.dart';

abstract class LoginUserRepository {
  
  Future<SelectUser> loginUser(String emailUser, String passwordUser);

}