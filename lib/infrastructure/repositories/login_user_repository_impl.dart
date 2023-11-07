
import 'package:in_library/domain/datasources/login_user_datasource.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/domain/repositories/login_user_repository.dart';

class LoginUserRepositoryImpl extends LoginUserRepository{

  final LoginUserDatasource datasource;

  LoginUserRepositoryImpl(
    this.datasource
  );

  @override
  Future<SelectUser> loginUser({String emailUser = '', String passwordUser = ''}) {
    return datasource.loginUser(emailUser: emailUser, passwordUser: passwordUser);
  }
  
  @override
  Future<SelectUser> dataUser({String emailUser = ''}) {
    return datasource.dataUser(emailUser: emailUser);
  }

}