class Reglament {
  int idTitles;
  String nameTitle;
  int statusTitle;
  String typeTitle;
  int idCover;
  String coverName;
  List<Chapter> chapters;

  Reglament({
    required this.idTitles,
    required this.nameTitle,
    required this.statusTitle,
    required this.typeTitle,
    required this.idCover,
    required this.coverName,
    required this.chapters,
  });

  factory Reglament.fromJson(Map<String, dynamic> json) {
    List<Chapter> chapters = [];
    if (json['chapters'] != null) {
      json['chapters'].forEach((chapter) {
        chapters.add(Chapter.fromJson(chapter));
      });
    }

    return Reglament(
      idTitles: json['idTitles'],
      nameTitle: json['nameTitle'],
      statusTitle: json['statusTitle'],
      typeTitle: json['typeTitle'],
      idCover: json['idCover'],
      coverName: json['coverName'],
      chapters: chapters,
    );
  }
}

class Chapter {
  int idChapter;
  String nameChapter;
  List<Section> sections;
  List<Article> articlesChapter;

  Chapter({
    required this.idChapter,
    required this.nameChapter,
    required this.sections,
    required this.articlesChapter,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<Section> sections = [];
    if (json['sections'] != null) {
      json['sections'].forEach((section) {
        sections.add(Section.fromJson(section));
      });
    }

    List<Article> articlesChapter = [];
    if (json['articlesChapter'] != null) {
      json['articlesChapter'].forEach((article) {
        articlesChapter.add(Article.fromJson(article));
      });
    }

    return Chapter(
      idChapter: json['idChapter'],
      nameChapter: json['nameChapter'],
      sections: sections,
      articlesChapter: articlesChapter,
    );
  }
}

class Section {
  int idSection;
  String nameSection;
  List<Article> articles;

  Section({
    required this.idSection,
    required this.nameSection,
    required this.articles,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    List<Article> articles = [];
    if (json['articles'] != null) {
      json['articles'].forEach((article) {
        articles.add(Article.fromJson(article));
      });
    }

    return Section(
      idSection: json['idSection'],
      nameSection: json['nameSection'],
      articles: articles,
    );
  }
}

class Article {
  int idArticle;
  String nameArticle;
  List<Paragraph> paragraphs;

  Article({
    required this.idArticle,
    required this.nameArticle,
    required this.paragraphs,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    List<Paragraph> paragraphs = [];
    if (json['paragraphs'] != null) {
      json['paragraphs'].forEach((paragraph) {
        paragraphs.add(Paragraph.fromJson(paragraph));
      });
    }

    return Article(
      idArticle: json['idArticle'],
      nameArticle: json['nameArticle'],
      paragraphs: paragraphs,
    );
  }
}

class Paragraph {
  int idParagraph;
  String paragraph;

  Paragraph({
    required this.idParagraph,
    required this.paragraph,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      idParagraph: json['idParagraph'],
      paragraph: json['paragraph'],
    );
  }
}
