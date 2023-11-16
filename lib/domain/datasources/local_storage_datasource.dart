
import 'package:in_library/domain/entities/select_user.dart';

abstract class LocalStorageDatasource{

  Future<void> toogleLogin(SelectUser user);

  Future<bool> islogged(int userId);

  Future<List<SelectUser>> loadUserData({offset = 0, limit = 1});

  Future<void> updateData(String idUser, String name, String lastname, String birthday, String phone);

}