import 'package:in_library/domain/entities/titles.dart';
import 'package:in_library/infrastructure/models/titledb/title_titledb.dart';

class TitleMapper {
  static Titles titleDBToEntity(TitleTilteDB titledb) => Titles(
      idTitles: titledb.idTitles,
      nameTitle: titledb.nameTitle,
      idCover: titledb.idCover,
      coverName: titledb.coverName
  );
}