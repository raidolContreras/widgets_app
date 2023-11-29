class FavoriteFavoriteDb {
    final int idTitle;
    final String nameTitle;
    final int idArticle;
    final String nameArticle;
    final String nameCover;

    FavoriteFavoriteDb({
        required this.idTitle,
        required this.nameTitle,
        required this.idArticle,
        required this.nameArticle,
        required this.nameCover,
    });

    factory FavoriteFavoriteDb.fromJson(Map<String, dynamic> json) => FavoriteFavoriteDb(
        idTitle: json["idTitle"],
        nameTitle: json["name_title"],
        idArticle: json["idArticle"],
        nameArticle: json["nameArticle"],
        nameCover: (json["cover_name"] != null) 
          ? 'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${json["idTitles"] }/${json["cover_name"]}'
          : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
    );

    Map<String, dynamic> toJson() => {
        "idTitle": idTitle,
        "name_title": nameTitle,
        "idArticle": idArticle,
        "nameArticle": nameArticle,
        "name_cover": nameCover,
    };
}