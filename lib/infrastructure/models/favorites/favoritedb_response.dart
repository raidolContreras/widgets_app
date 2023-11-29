import 'package:in_library/infrastructure/models/favorites/favorite_favoritedb.dart';

class FavoriteDbResponce {
    final List<FavoriteFavoriteDb> results;

    FavoriteDbResponce({
        required this.results,
    });

    factory FavoriteDbResponce.fromJson(Map<String, dynamic> json) => FavoriteDbResponce(
        results: (json['results'] as List<dynamic>)
            .map((item) => FavoriteFavoriteDb.fromJson(item))
            .toList(),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}