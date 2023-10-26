class StatementsModels {
  static const String getReglaments = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.type_title = 'Reglamento'";

  static const String getReglament = "SELECT * FROM app_titles t LEFT JOIN app_covers ac ON t.idTitles = ac.Title_idTitles WHERE t.idTitles = ?";

  static const String getChapters = "SELECT * FROM app_chapter WHERE Title_idTitles = ?";

  static const String getSections = "SELECT * FROM app_sections WHERE Chapter_idChapters = ?";

}
