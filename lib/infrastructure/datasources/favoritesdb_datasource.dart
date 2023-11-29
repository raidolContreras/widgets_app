import 'package:dio/dio.dart';
import 'package:in_library/domain/datasources/favorite_datasource.dart';
import 'package:in_library/domain/entities/favorites.dart';
import 'package:in_library/infrastructure/mappers/favorite_mapper.dart';
import 'package:in_library/infrastructure/models/favorites/favoritedb_response.dart';

class FavoritesbdDatasource extends FavoriteDatasource{

    final dio = Dio(BaseOptions(
      baseUrl: 'https://app-fiscal.inscripcionesccm.online/api-fiscal/api.php',
    ));
    
      @override
      Future<List<Favorites>> loadfavorites(int userId) async{

    final response = await dio.get('?listArticle=$userId');
    
    final favoritesDBResponse = FavoriteDbResponce.fromJson(response.data);

    final List<Favorites> favorites = favoritesDBResponse.results.map(
      (favoritesdb) => FavoritesMapper.favoritesDBToEntity(favoritesdb)
    ).toList();

    return favorites;

  }


}