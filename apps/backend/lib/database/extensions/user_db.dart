import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class UserDb {
  static final _crud = CrudDb<User>(
    table: Tables.users,
    fromJson: User.fromJson,
    toJson: _toJson,
    primaryKey: 'id',
    excludeOnCreate: [],
  );

  static Map<String, dynamic> _toJson(User data) => data.toJson();

  static Future<String?> checkAccount(
    Connection connection,
    String email,
    String password,
  ) async {
    final result = await _crud.query(
      connection,
      'SELECT * FROM ${Tables.users} WHERE email = @email AND password = @password',
      {'email': email, 'password': password},
    );
    if (result.isNotEmpty) return result.first.accessToken;
    return null;
  }

  static Future<bool> create(Connection connection, User? data) async {
    final result = await _crud.create(connection, data);
    return result.affectedRows > 0;
  }

  static Future<User> read(Connection connection, String id) =>
      _crud.read(connection, id);

  static Future<String> getUserId(
    Connection connection,
    String accessToken,
  ) async {
    final result = await _crud.query(
      connection,
      'SELECT * FROM ${Tables.users} WHERE access_token = @token',
      {'token': accessToken},
    );
    if (result.isNotEmpty) return result.first.id;
    return '';
  }
}
