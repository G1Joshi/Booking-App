// ignore_for_file: non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class BookingDb {
  static String get table => Tables.bookings;

  static Future<void> create(
    Connection connection,
    Booking? data,
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

  static Future<Booking> read(
    Connection connection,
    String roomId,
    String bookingId,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE room_id = '$roomId' AND id = '$bookingId'",
    );
    final data = result
        .map((row) => Booking.fromJson(row.toColumnMap()))
        .toList();
    return data.first;
  }

  static Future<Booking> readAll(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE room_id = '$id'",
    );
    final data = result
        .map((row) => Booking.fromJson(row.toColumnMap()))
        .toList();
    return data.first;
  }

  static Future<void> update(
    Connection connection,
    Booking? data,
    String roomId,
    String bookingId,
  ) async {
    var values = '';
    data?.toJson().forEach((key, value) {
      if (values != '') values += ', ';
      values += "$key = '$value'";
    });

    await connection.execute(
      'UPDATE $table '
      'SET $values '
      "WHERE room_id = '$roomId' AND id = '$bookingId'",
    );
  }

  static Future<void> delete(
    Connection connection,
    String roomId,
    String bookingId,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE room_id = '$roomId' AND id = '$bookingId'",
    );
  }

  static Future<void> deleteAll(
    Connection connection,
    String roomId,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE room_id = '$roomId'",
    );
  }
}
