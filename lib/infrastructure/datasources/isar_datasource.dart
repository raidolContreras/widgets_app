
import 'package:in_library/domain/datasources/local_storage_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';

class IsarDatasource extends LocalStorageDatasource{
  @override
  Future<bool> islogged(int userId) {
    // TODO: implement islogged
    throw UnimplementedError();
  }

  @override
  Future<void> toogleLogin(SelectUser user) {
    // TODO: implement toogleLogin
    throw UnimplementedError();
  }
  
  @override
  Future<SelectUser> loadUserData({offset = 0}) {
    // TODO: implement loadUserData
    throw UnimplementedError();
  }

}