import 'package:in_library/infrastructure/models/titledb/title_titledb.dart';

class TitlesDbResponse {
  final List<TitleTilteDB> result; // Cambio a List

  TitlesDbResponse({
    required this.result,
  });

  factory TitlesDbResponse.fromJson(Map<String, dynamic> json) => TitlesDbResponse(
        result: (json['results'] as List<dynamic>)
            .map((item) => TitleTilteDB.fromJson(item))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
        "results": result.map((item) => item.toJson()).toList(),
  };
}
