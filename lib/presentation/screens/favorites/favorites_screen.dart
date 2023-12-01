import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/presentation/providers/favorites/favorites_provider.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  static const name = 'favorites_screen';
  final String userId;

  const FavoritesScreen({super.key, required this.userId});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulación de carga de datos
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    ref.read(allFavoritesProvider.notifier).loadNextFavorite(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshFavorites() async {
    await ref.read(allFavoritesProvider.notifier).loadNextFavorite(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Favorites> favorites = ref.watch(allFavoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis artículos favoritos',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: _refreshFavorites,
          child: isLoading
              ? _buildLoadingIndicator()
              : favorites.isEmpty
                  ? _buildEmptyFavoritesMessage()
                  : ListView(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: favorites.map((favorite) {
                            return _buildFavoriteItem(favorite);
                          }).toList(),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(Favorites favorite) {
    final colors = Theme.of(context).colorScheme;
    return FadeInDown(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3 - 12,
        child: GestureDetector(
          onTap: () => context.push('/Article/${favorite.idArticle}'),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colors.error,  // Color del borde
                width: 1,            // Ancho del borde
              ),
              borderRadius: BorderRadius.circular(10),  // Radio del borde
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(favorite.nameCover),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favorite.nameTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        favorite.nameArticle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
    
        ),
      ),
    );
  }

  Widget _buildEmptyFavoritesMessage() {
    return Center(
      child: Text(
        'Aún no has agregado artículos a tus favoritos.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
