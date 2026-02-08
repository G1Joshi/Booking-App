// ignore_for_file: non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class RoomDb {
  static String get table => Tables.rooms;

  static Future<void> create(
    Connection connection,
    Room? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toJson().keys.forEach((key) {
      if (key != 'id') {
        if (keys != '') {
          keys += ', ';
          values += ', ';
        }
        keys += key;
        values += '@$key';
      }
    });
    await connection.execute(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      parameters: data?.toJson(),
    );
  }

  static Future<Room> read(
    Connection connection,
    String hotelId,
    String roomId,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$roomId'",
    );
    final data = result.map((row) => Room.fromJson(row.toColumnMap())).toList();
    return data.first;
  }

  static Future<List<Room>> readAll(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((row) => Room.fromJson(row.toColumnMap())).toList();
    return data;
  }

  static Future<void> update(
    Connection connection,
    Room? data,
    String hotelId,
    String roomId,
  ) async {
    var values = '';
    data?.toJson().forEach((key, value) {
      if (values != '') values += ', ';
      if (!key.contains('id')) {
        value = value.toString().replaceAll('[', '{');
        value = value.toString().replaceAll(']', '}');
      }
      values += "$key = '$value'";
    });

    await connection.execute(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$hotelId' AND id = '$roomId'",
    );
  }

  static Future<void> delete(
    Connection connection,
    String hotelId,
    String roomId,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$roomId'",
    );
  }

  static Future<void> deleteAll(
    Connection connection,
    String id,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE hotel_id = '$id'",
    );
  }
}
