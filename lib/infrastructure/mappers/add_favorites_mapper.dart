import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/infrastructure/models/add_favorites/add_favoritesdb_response.dart';

class AddFavoritesMapper {
  static AddFavorites toogleFavoritesDBEntity(AddFavoriteDbResponse toogleResult) => AddFavorites(message: toogleResult.message);
}