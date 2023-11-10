import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/domain/datasources/reglaments_datasource.dart';
import 'package:in_library/domain/repositories/reglaments_repository.dart';

class ReglamentRepositoryImpl extends ReglamentsRepository{

  final ReglamentsDatasource datasource;

  ReglamentRepositoryImpl(
    this.datasource
  );

  @override
  Future<Reglament> getReglament(String reglamentId) {
    return datasource.getReglament(reglamentId);
  }

}