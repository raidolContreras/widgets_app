import 'package:in_library/domain/datasources/favorite_datasource.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/domain/repositories/favorites_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository{
  
  final FavoriteDatasource datasource;

  FavoriteRepositoryImpl(
    this.datasource
  );

  @override
  Future<List<Favorites>> loadfavorites(String userId) {
    return datasource.loadfavorites(userId);
  }

  @override
  Future<AddFavorites> toogleFavorites(String idArticle, String userId) {
    return datasource.toogleFavorites(idArticle, userId);
  }

}