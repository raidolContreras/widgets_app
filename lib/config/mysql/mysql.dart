import 'package:mysql1/mysql1.dart';

class MySql {
  // Los datos de acceso a la base de datos
  static String host = 'inscripcionesccm.online';
  static String user = 'u895534236_ocontreras';
  static String password = 'fjz6GG5l7ly{';
  static String db = 'u895534236_inscripciones';
  static int port = 3306; // El puerto por defecto para MySQL

  // El constructor vacío
  MySql();

  // El método que devuelve la conexión
  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db
      );
    return await MySqlConnection.connect(settings);
  }
}

