import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/presentation/providers/favorites/favorites_repository_provider.dart';

final allFavoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Favorites>>((ref) {
  
  final fetchMoreFavorites = ref.watch(favoritesRepositoryProvider).loadfavorites;

  return FavoritesNotifier(
    fetchMoreFavorites: fetchMoreFavorites
  );
});

typedef FavoriteCallback = Future<List<Favorites>> Function(String userId);

class FavoritesNotifier extends StateNotifier<List<Favorites>>{

  FavoriteCallback fetchMoreFavorites;

  FavoritesNotifier({
    required this.fetchMoreFavorites
  }): super([]);
  
  Future<void> loadNextFavorite(String userId) async{
    
    final List<Favorites> favorites = await fetchMoreFavorites(userId);
    state = [];
    state = [...state, ...favorites];

  }

}