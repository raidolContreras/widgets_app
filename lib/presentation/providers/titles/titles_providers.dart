import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/titles.dart';
import 'package:in_library/presentation/providers/titles/titles_repository_provider.dart';

final allTitlesProvider = StateNotifierProvider<TitlesNotifier, List<Titles>>((ref) {
  
  final fetchMoreTitles = ref.watch(titleRepositoryProvider).getTitles;

  return TitlesNotifier(
    fetchMoreTitles: fetchMoreTitles
  );
});

typedef TitleCallback = Future<List<Titles>> Function();

class TitlesNotifier extends StateNotifier<List<Titles>>{

  TitleCallback fetchMoreTitles;

  TitlesNotifier({
    required this.fetchMoreTitles
  }): super([]);
  
  Future<void> loadNextPage() async{
    
    final List<Titles> titles = await fetchMoreTitles();

    state = [...state, ...titles];

  }

}