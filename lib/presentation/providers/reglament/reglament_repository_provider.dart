
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/reglamentsdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/reglament_repository_impl.dart';

// Provider de solo lectura, es inmutable
final reglamentRepositoryProvider = Provider((ref) {
  return ReglamentRepositoryImpl(ReglamentsDbDatasource(baseUrl: 'https://app-fiscal.hucco.com.mx/'));
});