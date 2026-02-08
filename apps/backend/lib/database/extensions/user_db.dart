// ignore_for_file: non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class UserDb {
  static String get table => Tables.users;

  static Future<String?> checkAccount(
    Connection connection,
    String email,
    String password,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE email = '$email' AND password = '$password'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    if (data.isNotEmpty) {
      return data.first.accessToken;
    }
    return null;
  }

  static Future<bool> create(
    Connection connection,
    User? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toJson().keys.forEach((key) {
      if (keys != '') {
        keys += ', ';
        values += ', ';
      }
      keys += key;
      values += '@$key';
    });
    final result = await connection.execute(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      parameters: data?.toJson(),
    );
    return result.affectedRows > 0;
  }

  static Future<User> read(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE id = '$id'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    return data.first;
  }

  static Future<String> getUserId(
    Connection connection,
    String accessToken,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE access_token = '$accessToken'",
    );
    final data = result.map((row) => User.fromJson(row.toColumnMap())).toList();
    if (data.isNotEmpty) {
      return data.first.id;
    }
    return '';
  }
}
