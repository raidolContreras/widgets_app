import 'package:in_library/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:in_library/infrastructure/datasources/isar_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loggedUserRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});