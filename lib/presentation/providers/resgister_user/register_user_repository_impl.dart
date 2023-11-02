import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/register_userdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/register_user_repository_impl.dart';

final registerUserRepositoryProvider = Provider((ref) {
  return RegisterUserRepositoryImpl(RegisterUserdbDatasource());
});