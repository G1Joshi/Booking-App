// ignore_for_file: non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class HotelDb {
  static String get table => Tables.hotels;

  static Future<int> getId(Connection connection) async {
    final result = await connection.execute(
      "SELECT nextval('${table}_id_seq')",
    );
    final id = result.first.first as int? ?? 0;
    return id;
  }

  static Future<void> create(
    Connection connection,
    Hotel? data,
  ) async {
    var keys = '';
    var values = '';
    _toDatabase(data).keys.forEach((key) {
      if (keys != '') {
        keys += ', ';
        values += ', ';
      }
      keys += key;
      values += '@$key';
    });
    await connection.execute(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      parameters: _toDatabase(data),
    );
  }

  static Future<Hotel> read(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE id = '$id'",
    );
    final data = result
        .map((row) => Hotel.fromJson(row.toColumnMap()))
        .toList();
    return data.first;
  }

  static Future<List<Hotel>> readAll(Connection connection) async {
    final result = await connection.execute(
      'SELECT * FROM ${Tables.hotels} '
      'ORDER BY id',
    );
    final data = result.map((row) => _fromDatabase(row.toColumnMap())).toList();
    return data;
  }

  static Future<void> update(
    Connection connection,
    Hotel? data,
    String id,
  ) async {
    var values = '';
    _toDatabase(data).forEach((key, value) {
      if (values != '') values += ', ';
      values += "$key = '$value'";
    });

    await connection.execute(
      'UPDATE $table '
      'SET $values '
      "WHERE id = '$id'",
    );
  }

  static Future<void> delete(
    Connection connection,
    String id,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE id = '$id'",
    );
  }

  static Future<List<Hotel>> search(
    Connection connection,
    String locality,
    int distance,
    String checkin,
    String checkout,
    int rooms,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      'where id in ( '
      '   SELECT hotel_id FROM ( SELECT r.id, r.hotel_id, '
      "   CASE WHEN ( b.checkin BETWEEN '$checkin' AND '$checkout' OR b.checkout BETWEEN '$checkin' AND '$checkout' OR '$checkin' BETWEEN b.checkin AND b.checkout OR '$checkout' BETWEEN b.checkin AND b.checkout ) "
      '   THEN r.count - COALESCE(SUM(b.rooms), 0) ELSE r.count '
      '   END AS available_rooms '
      '   FROM ${Tables.rooms} r LEFT JOIN ${Tables.bookings} b on r.id = b.room_id '
      '   GROUP BY r.id, b.checkin, b.checkout ) AS subquery '
      '   WHERE available_rooms >= $rooms '
      'INTERSECT '
      '   SELECT h.hotel_id FROM ${Tables.address} h '
      '   JOIN ${Tables.localities} l ON distance(h.latitude, h.longitude, l.latitude, l.longitude) < $distance '
      "   WHERE l.name iLIKE '%$locality%' "
      ')',
    );
    final data = result.map((row) => _fromDatabase(row.toColumnMap())).toList();
    return data;
  }

  static Future<List<Hotel>> filter(
    Connection connection,
    String? star,
    String? rating,
    String? propertyType,
    String? budget,
  ) async {
    var query = '';
    if (star != null) {
      query += 'AND star >= ANY (ARRAY${star.split(',')})';
    }
    if (rating != null) {
      query += 'AND rating >= ANY (ARRAY${rating.split(',')})';
    }
    if (propertyType != null) {
      query +=
          'AND property_type = ANY (ARRAY${propertyType.split(',').map((w) => "'$w'").toList()})';
    }
    if (budget != null) {
      query += 'AND rooms_starting_price <= ANY (ARRAY${budget.split(',')})';
    }
    final result = await connection.execute(
      'SELECT * FROM $table '
      'WHERE ${query.split('AND').skip(1).join('AND')}',
    );
    final data = result.map((row) => _fromDatabase(row.toColumnMap())).toList();
    return data;
  }

  static Map<String, dynamic> _toDatabase(Hotel? data) {
    if (data == null) return {};
    return <String, dynamic>{
      'id': data.id,
      'name': data.name,
      'description': data.description,
      'property_type': data.propertyType,
      'chain': data.chain,
      'star': data.star,
      'rating': data.rating,
      'rooms_starting_price': data.roomsStartingPrice,
      'cover_image': data.coverImage,
    };
  }

  static Hotel _fromDatabase(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      description: json['description'] as String,
      propertyType: json['property_type'] as String,
      chain: json['chain'] as String,
      star: json['star'] as int,
      rating: json['rating'] as num,
      roomsStartingPrice: json['rooms_starting_price'] as int,
      coverImage: json['cover_image'] as String,
    );
  }
}
