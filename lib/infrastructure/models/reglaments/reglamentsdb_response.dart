class ReglamentDb {
    final int idTitles;
    final String nameTitle;
    final int statusTitle;
    final String typeTitle;
    final int idCover;
    final String coverName;
    final List<Chapter> chapters;

    ReglamentDb({
        required this.idTitles,
        required this.nameTitle,
        required this.statusTitle,
        required this.typeTitle,
        required this.idCover,
        required this.coverName,
        required this.chapters,
    });

    factory ReglamentDb.fromJson(Map<String, dynamic> json) => ReglamentDb(
        idTitles: json["idTitles"],
        nameTitle: json["nameTitle"],
        statusTitle: json["statusTitle"],
        typeTitle: json["typeTitle"],
        idCover: json["idCover"],
        coverName: json["coverName"],
        chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idTitles": idTitles,
        "nameTitle": nameTitle,
        "statusTitle": statusTitle,
        "typeTitle": typeTitle,
        "idCover": idCover,
        "coverName": coverName,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
    };
}

class Chapter {
    final int idChapter;
    final String nameChapter;
    final List<Section> sections;
    final List<Article> articlesChapter;

    Chapter({
        required this.idChapter,
        required this.nameChapter,
        required this.sections,
        required this.articlesChapter,
    });

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        idChapter: json["idChapter"],
        nameChapter: json["nameChapter"],
        sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
        articlesChapter: List<Article>.from(json["articlesChapter"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idChapter": idChapter,
        "nameChapter": nameChapter,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "articlesChapter": List<dynamic>.from(articlesChapter.map((x) => x.toJson())),
    };
}

class Article {
    final int idArticle;
    final String nameArticle;
    final List<Paragraph> paragraphs;

    Article({
        required this.idArticle,
        required this.nameArticle,
        required this.paragraphs,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
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
    final String paragraph;

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

class Section {
    final int idSection;
    final String nameSection;
    final List<Article> articles;

    Section({
        required this.idSection,
        required this.nameSection,
        required this.articles,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        idSection: json["idSection"],
        nameSection: json["nameSection"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idSection": idSection,
        "nameSection": nameSection,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}
