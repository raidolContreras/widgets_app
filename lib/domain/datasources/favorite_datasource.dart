import 'package:in_library/domain/entities/favorites.dart';

abstract class FavoriteDatasource {

  Future<List<Favorites>> loadfavorites(int userId);

}