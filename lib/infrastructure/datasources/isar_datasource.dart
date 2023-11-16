
import 'package:in_library/domain/datasources/local_storage_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class IsarDatasource extends LocalStorageDatasource{
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      // Abrir la base de datos de Isar pasando el directorio
      return await Isar.open(
        [SelectUserSchema], 
        inspector: true,
        directory: dir.path
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> islogged(int userId) async {
    final isar = await db;
    
    final SelectUser? isLoggedUser = await isar.selectUsers
    .filter()
    .idUserEqualTo(userId)
    .findFirst();

    return isLoggedUser != null;
  }

  @override
  Future<void> toogleLogin(SelectUser user) async {
    final isar = await db;

    final logerUser = await isar.selectUsers
    .filter()
    .idUserEqualTo(user.idUser)
    .findFirst();

    if (logerUser != null) {
      //cerrar sesión
      
      isar.writeTxnSync(() => isar.selectUsers.deleteSync(logerUser.isarId!));

      return;
      
    }
    // iniciar sesión

    isar.writeTxnSync(() => isar.selectUsers.putSync(user));
    
  }
  
  @override
  Future<void> updateData(String idUser, String name, String lastname, String birthday, String phone) async {
    final isar = await db;
    final int id = int.parse(idUser);
    await isar.writeTxn(() async {
      final userToUpdate = await isar.selectUsers.where().filter().idUserEqualTo(id).findFirst();

      if (userToUpdate != null) {
        userToUpdate.firstname = name;
        userToUpdate.lastname = lastname;
        userToUpdate.birthday = birthday;
        userToUpdate.phone = phone;

        await isar.selectUsers.put(userToUpdate);
      }
    });
  }
  
  @override
  Future<List<SelectUser>> loadUserData({offset = 0, limit = 1}) async {
    final isar = await db;
    return isar.selectUsers.where()
    .offset(offset)
    .limit(limit)
    .findAll();
  }

}