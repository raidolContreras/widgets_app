import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/infrastructure/datasources/favoritesdb_datasource.dart';
import 'package:in_library/presentation/providers/add_favorites/add_favorites_provider.dart';

import 'dart:async';

class IsFavorite extends ConsumerStatefulWidget {
  const IsFavorite({
    Key? key,
    required this.idArticle,
    required this.userId,
  }) : super(key: key);

  final String idArticle;
  final String userId;

  @override
  ConsumerState<IsFavorite> createState() => IsFavoriteState();
}

class IsFavoriteState extends ConsumerState<IsFavorite> {
  late IsFavorites isFavorite;
  bool star = false;
  Icon favorite = const Icon(Icons.star_border_outlined);

  @override
  void initState() {
    super.initState();
    _initializeFavoritesChain();
  }

  Future<void> _initializeFavoritesChain() async {
    await _delayedIsFavorite(500); // Ajusta el valor del delay según tus necesidades
    await _delayedIsFavorite(500); // Ajusta el valor del delay según tus necesidades
    // Agrega más llamadas a _delayedIsFavorite según sea necesario
  }

  Future<void> _delayedIsFavorite(int delay) async {
    await Future.delayed(Duration(milliseconds: delay));
    await _isFavorite();
  }

  Future<void> _isFavorite() async {
    final isFavoritedbDatasource = FavoritesbdDatasource();
    isFavorite =
        await isFavoritedbDatasource.isFavorite(widget.idArticle, widget.userId);
    setState(() {
      star = isFavorite.message;
    });
    // ignore: use_build_context_synchronously
    final colors = Theme.of(context).colorScheme;
    if (star) {
      favorite = Icon(Icons.star_rounded, color: colors.primary);
    } else {
      favorite = const Icon(Icons.star_border_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () async {
        ref.read(toggleFavorites.notifier)
            .fetchToggleFavorites(widget.idArticle, widget.userId);
        setState(() {
          if (star) {
            favorite = const Icon(Icons.star_border_outlined);
            star = !star;
          } else {
            favorite = Icon(Icons.star_rounded, color: colors.primary);
            star = !star;
          }
        });
      },
      icon: FadeInRight(child: favorite),
    );
  }
}
