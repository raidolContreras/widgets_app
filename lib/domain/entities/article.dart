class Article {
  String idArticle;
  String nameArticle;
  List<Paragraph> paragraphs;

  Article({
    required this.idArticle,
    required this.nameArticle,
    required this.paragraphs,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    List<dynamic> paragraphsData = json['paragraphs'];
    List<Paragraph> paragraphs = paragraphsData
        .map((paragraph) => Paragraph.fromJson(paragraph))
        .toList();

    return Article(
      idArticle: json['idArticle'],
      nameArticle: json['nameArticle'],
      paragraphs: paragraphs,
    );
  }
}

class Paragraph {
  String? idParagraph;
  String? paragraph;

  Paragraph({
    this.idParagraph,
    this.paragraph,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      idParagraph: json['idParagraph'],
      paragraph: json['paragraph'],
    );
  }
}
