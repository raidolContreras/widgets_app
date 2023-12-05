import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/infrastructure/datasources/favoritesdb_datasource.dart';
import 'package:in_library/presentation/providers/add_favorites/add_favorites_provider.dart';

class IsFavorite extends ConsumerStatefulWidget {
  const IsFavorite({
    super.key, 
    required this.idArticle,
    required this.userId,
  });

  final String idArticle;
  final String userId;

  @override
  ConsumerState<IsFavorite> createState() => IsFavoriteState();
}

class IsFavoriteState extends ConsumerState<IsFavorite> {

  late IsFavorites isFavorite;
  bool star = false;
  Icon favorite = const Icon(Icons.star_border_outlined);

  Future<void> _isFavorite() async {
    final isFavoritedbDatasource = FavoritesbdDatasource();
    isFavorite = await isFavoritedbDatasource.isFavorite(widget.idArticle, widget.userId);
    
    setState(() {
      star = isFavorite.message;
    });
    if(star){
      favorite = const Icon(Icons.star_rounded);
    }else {
      favorite = const Icon(Icons.star_border_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    _isFavorite();
    return IconButton(
      onPressed: () async {
        ref.read(toggleFavorites.notifier).fetchToggleFavorites(widget.idArticle, widget.userId);
        setState(() {
          if(star){
            favorite = const Icon(Icons.star_border_outlined);
          } else {
            favorite = const Icon(Icons.star_rounded);
          }
        });
      }, 
      icon: ElasticInDown(child: favorite),
    );
  }
}