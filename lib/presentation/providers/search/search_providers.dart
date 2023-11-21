import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/search.dart';
import 'package:in_library/presentation/providers/search/search_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final seacherResultsProvider = StateNotifierProvider<SearchedTextNotifier, List<Search>>((ref) {
  final searchRepository = ref.read(searchRepositoryProvider);

  return SearchedTextNotifier(
    searchResults: searchRepository.searchResults,
    ref: ref
  );
  
});

typedef SearchResultsCallback = Future <List<Search>> Function(String query);

class SearchedTextNotifier extends StateNotifier<List<Search>> {

  final SearchResultsCallback searchResults;

  final Ref ref;

  SearchedTextNotifier({
    required this.searchResults,
    required this.ref,
  }): super([]);

  Future <List<Search>> searchResultsByQuery( String query ) async {

    final List<Search> results = await searchResults(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = results;
    return results;
  }

}