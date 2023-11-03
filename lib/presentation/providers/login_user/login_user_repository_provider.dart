import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/login_userdb.datasource.dart';
import 'package:in_library/infrastructure/repositories/login_user_repository_impl.dart';

final loginUserRepositoryProvider = Provider((ref) {
  return LoginUserRepositoryImpl(LoginUserdbDatasource());
});