class ArticlesDb {
    final int idArticle;
    final String nameArticle;
    final List<Paragraph> paragraphs;

    ArticlesDb({
        required this.idArticle,
        required this.nameArticle,
        required this.paragraphs,
    });

    factory ArticlesDb.fromJson(Map<String, dynamic> json) => ArticlesDb(
        idArticle: json["idArticle"],
        nameArticle: json["nameArticle"],
        paragraphs: List<Paragraph>.from(json["paragraphs"].map((x) => Paragraph.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idArticle": idArticle,
        "nameArticle": nameArticle,
        "paragraphs": List<dynamic>.from(paragraphs.map((x) => x.toJson())),
    };
}

class Paragraph {
    final int idParagraph;
    final dynamic paragraph;

    Paragraph({
        required this.idParagraph,
        required this.paragraph,
    });

    factory Paragraph.fromJson(Map<String, dynamic> json) => Paragraph(
        idParagraph: json["idParagraph"],
        paragraph: json["paragraph"],
    );

    Map<String, dynamic> toJson() => {
        "idParagraph": idParagraph,
        "paragraph": paragraph,
    };
}