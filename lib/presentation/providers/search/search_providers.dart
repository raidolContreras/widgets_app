import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/search.dart';
import 'package:in_library/presentation/providers/search/search_repository_provider.dart';

final allSearchResultsProvider = StateNotifierProvider((ref) {

  final fetchResults = ref.watch(searchRepositoryProvider).searchResults;

  return SearchNotifier(
    fetchResults: fetchResults
  );

});

typedef SearchCallback = Future<List<Search>> Function(String search);

class SearchNotifier extends StateNotifier<List<Search>> {
  SearchCallback fetchResults;

  SearchNotifier({
    required this.fetchResults
  }): super([]);

    Future<void> loadResults(String search) async{
    
    final List<Search> results = await fetchResults(search);

    state = [...state, ...results];

  }
}