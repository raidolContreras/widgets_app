import 'package:in_library/domain/entities/titles.dart';
import 'package:in_library/domain/datasources/title_datasource.dart';
import 'package:in_library/domain/repositories/titles_repository.dart';

class TitleRepositoryImpl extends TitleRepository{

  final TitleDatasource datasource;

  TitleRepositoryImpl(
    this.datasource
  );

  @override
  Future<List<Titles>> getTitles() {
    return datasource.getTitles();
  }

}