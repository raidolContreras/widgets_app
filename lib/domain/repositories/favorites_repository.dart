import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/domain/entities/favorites.dart';

abstract class FavoriteRepository {

  Future<List<Favorites>> loadfavorites(String userId);

  Future<AddFavorites> toogleFavorites(String idArticle,String userId);

}