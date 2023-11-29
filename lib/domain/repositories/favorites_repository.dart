import 'package:in_library/domain/entities/favorites.dart';

abstract class FavoriteRepository {

  Future<List<Favorites>> loadfavorites(int userId);

}