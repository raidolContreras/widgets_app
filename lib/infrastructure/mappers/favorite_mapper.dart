import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/infrastructure/models/favorites/favorite_favoritedb.dart';

class FavoritesMapper {
  static Favorites favoritesDBToEntity(FavoriteFavoriteDb favoritedb) => Favorites(
      idTitle: favoritedb.idTitle,
      nameTitle: favoritedb.nameTitle,
      idArticle: favoritedb.idArticle,
      nameArticle: favoritedb.nameArticle,
      nameCover: favoritedb.nameCover
  );
}