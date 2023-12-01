import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/favorite_datasource.dart';
import 'package:in_library/domain/entities/add_favorites.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/infrastructure/mappers/add_favorites_mapper.dart';
import 'package:in_library/infrastructure/mappers/favorite_mapper.dart';
import 'package:in_library/infrastructure/models/add_favorites/add_favoritesdb_response.dart';
import 'package:in_library/infrastructure/models/favorites/favoritedb_response.dart';

class FavoritesbdDatasource extends FavoriteDatasource{

    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.inscripcionesccm.online/api-fiscal/api.php',
    ));
    
    @override
    Future<List<Favorites>> loadfavorites(String userId) async{

    final response = await dio.get('?listArticle=$userId');
    
    final favoritesDBResponse = FavoriteDbResponce.fromJson(response.data);

    final List<Favorites> favorites = favoritesDBResponse.results.map(
      (favoritesdb) => FavoritesMapper.favoritesDBToEntity(favoritesdb)
    ).toList();

    return favorites;

  }

  @override
  Future<AddFavorites> toogleFavorites(String idArticle, String userId) async {

    final response = await dio.get('?article=$idArticle&user=$userId');

    final addFavoritesDBResponse = AddFavoriteDbResponse.fromJson(response.data);

    final AddFavorites addFavorites = AddFavoritesMapper.toogleFavoritesDBEntity(addFavoritesDBResponse);

    return addFavorites;

  }


}