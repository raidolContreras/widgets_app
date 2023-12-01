import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/infrastructure/datasources/favoritesdb_datasource.dart';
import 'package:in_library/infrastructure/repositories/favorite_repository_impl.dart';

final addFavoritesRepositoryProvider = Provider((ref) {
  return FavoriteRepositoryImpl(FavoritesbdDatasource());
});