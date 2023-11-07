
import 'package:in_library/domain/entities/select_user.dart';

abstract class LocalStorageRepository{

  Future<void> toogleLogin(SelectUser user);

  Future<bool> islogged(int userId);
  
  Future<List<SelectUser>> loadUserData({offset = 1, limit = 1});

}