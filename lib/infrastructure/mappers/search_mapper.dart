import 'package:in_library/domain/entities/search.dart';
import 'package:in_library/infrastructure/models/search/search_searchdb.dart';

class SearchMapper {
  static Search searchDBToEntity(SearchSearchDB searchdb) => Search(
      idTitle: searchdb.idTitle,
      nameTitle: searchdb.nameTitle,
      idArticle: searchdb.idArticle,
      nameArticle: searchdb.nameArticle,
      paragraph: searchdb.paragraph,
      cover: searchdb.cover
  );
}