
import 'package:in_library/domain/entities/select_user.dart';

abstract class LocalStorageRepository{

  Future<void> toogleLogin(SelectUser user);

  Future<bool> islogged(int userId);
  
  Future<SelectUser> loadUserData({offset = 0});

}