import 'package:in_library/domain/datasources/favorite_datasource.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/domain/repositories/favorites_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository{
    final FavoriteDatasource datasource;

    FavoriteRepositoryImpl(
      this.datasource
    );

  @override
  Future<List<Favorites>> loadfavorites(int userId) {
    return datasource.loadfavorites(userId);
  }

}