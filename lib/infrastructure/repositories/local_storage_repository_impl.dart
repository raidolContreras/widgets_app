import 'package:in_library/domain/datasources/local_storage_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> islogged(int userId) {
    return datasource.islogged(userId);
  }

  @override
  Future<void> toogleLogin(SelectUser user) {
    return datasource.toogleLogin(user);
  }
  
  @override
  Future<List<SelectUser>> loadUserData({offset = 0, limit = 1}) {
    return datasource.loadUserData(offset: offset, limit: limit);
  }
}
