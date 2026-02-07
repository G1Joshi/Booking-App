import 'package:booking_backend/config/constants.dart';
import 'package:postgres/postgres.dart';

class DBConnection {
  factory DBConnection() => _instance;

  DBConnection._();

  static final DBConnection _instance = DBConnection._();

  static late Connection _connection;

  Future<void> _openConnection() async {
    if (!_connection.isOpen) await _open();
  }

  Future<void> _closeConnection() async {
    if (_connection.isOpen) await _connection.close();
  }

  Future<void> get connect => _openConnection();

  Future<void> get disconnect => _closeConnection();

  Connection get getConnection => _connection;

  Future<void> _open() async {
    _connection = await Connection.open(
      Endpoint(
        host: kHost,
        database: kDatabase,
        username: kUsername,
        password: kPassword,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }
}
