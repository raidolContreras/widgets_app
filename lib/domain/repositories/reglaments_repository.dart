import 'package:in_library/domain/entities/reglaments.dart';

abstract class ReglamentsRepository {
  Future<Reglament> getReglament(String reglamentId);
}