import 'package:in_library/domain/entities/titles.dart';

abstract class TitleRepository{
  Future<List<Titles>> getTitles();
}