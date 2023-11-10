import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/presentation/providers/reglament/reglament_repository_provider.dart';

final reglamentsNotifierProvider = StateNotifierProvider<ReglamentsNotifier, Reglament>((ref) {
  final fetchReglament = ref.watch(reglamentRepositoryProvider).getReglament;
  final initialReglament = Reglament(idTitles: 0, coverName: '', idCover: 0, nameTitle: '', statusTitle: 0, typeTitle: '', chapters: []); // Aquí necesitarías proporcionar un Reglament inicial

  return ReglamentsNotifier(
    initialReglament,
    fetchReglament: fetchReglament,
  );
});


typedef ReglamentCallback = Future<Reglament> Function(String);

class ReglamentsNotifier extends StateNotifier<Reglament> {
  ReglamentCallback fetchReglament;

  ReglamentsNotifier(super._state, {
    required this.fetchReglament,
  });

  Future<void> loadReglament(String reglamentId) async {
    final Reglament reglament = await fetchReglament(reglamentId);
    state = reglament;
  }
}
