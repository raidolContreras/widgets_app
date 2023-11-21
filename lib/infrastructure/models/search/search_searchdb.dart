class SearchSearchDB {
    final int idTitle;
    final String nameTitle;
    final int idArticle;
    final String nameArticle;
    final String paragraph;
    final String cover;

    SearchSearchDB({
        required this.idTitle,
        required this.nameTitle,
        required this.idArticle,
        required this.nameArticle,
        required this.paragraph,
        required this.cover,
    });

    factory SearchSearchDB.fromJson(Map<String, dynamic> json) => SearchSearchDB(
        idTitle: json["idTitle"],
        nameTitle: json["name_title"],
        idArticle: json["idArticle"],
        nameArticle: json["nameArticle"],
        paragraph: json["paragraph"],
        cover: (json["cover"] != null) 
          ? 'https://app-fiscal.inscripcionesccm.online/assets/images/covers/${json["idTitles"] }/${json["cover"]}'
          : 'https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg',
    );

    Map<String, dynamic> toJson() => {
        "idTitle": idTitle,
        "name_title": nameTitle,
        "idArticle": idArticle,
        "nameArticle": nameArticle,
        "paragraph": paragraph,
        "cover": cover,
    };
}