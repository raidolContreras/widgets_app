import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/infrastructure/models/registers/select_userdb.dart';
import 'package:intl/intl.dart';

class LoginUserMapper {
  static SelectUser loginUserDBToEntity(SelectUserDb loginResult) => SelectUser(
    idUser: loginResult.idUser,
    firstname: loginResult.firstname,
    lastname: loginResult.lastname,
    birthday: loginResult.birthday,
    email: loginResult.email,
    phone: loginResult.phone,
    creationDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(loginResult.creationDate),
    message: loginResult.message
  );
}