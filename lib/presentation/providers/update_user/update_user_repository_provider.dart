import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/update_userdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/update_user_repository_impl.dart';

final updateUserRepositoryProvider = Provider((ref) {
  return UpdateUserRepositoryImpl(UpdateUserdbDatasource());
});