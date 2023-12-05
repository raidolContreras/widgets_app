import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/presentation/providers/add_favorites/add_favorites_repository_provider.dart';

final toggleFavorites = StateNotifierProvider<AddFavoritesNotifier, Map<String, AddFavorites>>((ref) {

  final toggleFavoritesRepository = ref.watch(addFavoritesRepositoryProvider).toogleFavorites;

  return AddFavoritesNotifier(
    fetchToggleFavorites: toggleFavoritesRepository
  );

});

typedef AddFavoritesCallback = Future<AddFavorites> Function(
  String idArticle, String userId
);

class AddFavoritesNotifier extends StateNotifier<Map<String, AddFavorites>>{

  final AddFavoritesCallback fetchToggleFavorites;

  AddFavoritesNotifier({
    required this.fetchToggleFavorites
  }): super({});
  
  Future<void> loadDataUser(
    String idArticle, String userId
  ) async{
    if (state[idArticle] != null && state[userId] != null ) return;
    
    final toogleFavorite = await fetchToggleFavorites(idArticle, userId);

    state = {
      'idArticle': toogleFavorite,
      'userId': toogleFavorite,
    };

  }

}