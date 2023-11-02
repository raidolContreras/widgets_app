
import 'package:in_library/domain/datasources/register_user_datasource.dart';
import 'package:in_library/domain/entities/register_user.dart';
import 'package:in_library/domain/repositories/register_user_repository.dart';

class RegisterUserRepositoryImpl extends RegisterUserRepository {
  
  final RegisterUserDatasource datasource;

  RegisterUserRepositoryImpl(
    this.datasource
  );

  @override
  Future<RegisterUser> getRegisterUser(String nameUser, String emailUser, String passwordUser) {
    return datasource.getRegisterUser(nameUser, emailUser, passwordUser);
  }

}