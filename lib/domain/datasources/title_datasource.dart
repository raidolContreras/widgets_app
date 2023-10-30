import 'package:in_library/domain/entities/titles.dart';

abstract class TitleDatasource{
  Future<List<Titles>> getTitles();
}