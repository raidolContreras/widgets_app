import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/presentation/providers/add_favorites/add_favorites_repository_provider.dart';

final isFavoritesNotifier = StateNotifierProvider<IsFavoritesNotifier, Map<String, IsFavorites>>((ref) {
  final isFavoritesRepository = ref.watch(addFavoritesRepositoryProvider).isFavorite;
  return IsFavoritesNotifier(
    isFavoriteResponse: isFavoritesRepository
  );
});

typedef IsFavoritesCallback = Future<IsFavorites> Function(
  String idArticle, String userId
);

class IsFavoritesNotifier extends StateNotifier<Map<String, IsFavorites>> {
  final IsFavoritesCallback isFavoriteResponse;

  IsFavoritesNotifier({
    required this.isFavoriteResponse,
  }) : super({});

  Future<void> loadMessage(String messagePost) async {
    if (state[messagePost] != null) return;

    final message = await isFavoriteResponse(messagePost, '');
    state = {...state, messagePost: message };
  }

}