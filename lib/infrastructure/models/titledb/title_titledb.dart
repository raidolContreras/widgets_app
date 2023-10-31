class TitleTilteDB {
    final int idTitles;
    final String nameTitle;
    final int idCover;
    final String coverName;

    TitleTilteDB({
        required this.idTitles,
        required this.nameTitle,
        required this.idCover,
        required this.coverName,
    });

    factory TitleTilteDB.fromJson(Map<String, dynamic> json) => TitleTilteDB(
        idTitles: json["idTitles"],
        nameTitle: json["name_title"],
        idCover: (json["idCover"] != null) ? json["idCover"] : 0,
        coverName: (json["cover_name"] != null) 
          ? 'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${json["idTitles"] }/${json["cover_name"]}'
          : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
    );

    Map<String, dynamic> toJson() => {
        "idTitles": idTitles,
        "name_title": nameTitle,
        "idCover": idCover,
        "cover_name": coverName,
    };
}