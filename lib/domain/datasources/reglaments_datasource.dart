import 'package:in_library/domain/entities/reglaments.dart';

abstract class ReglamentsDatasource {
  Future<Reglament> getReglament(String reglamentId);
}