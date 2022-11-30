// ignore_for_file: lines_longer_than_80_chars, prefer_single_quotes

import 'package:booking_backend/models.dart/hotel_model.dart';
import 'package:booking_backend/service/crud_service.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class HotelService implements CrudService<Hotel> {
  HotelService(this.connection) : table = 'hotels';

  final PostgreSQLConnection connection;
  final String table;

  @override
  Future<Hotel> create(Hotel hotel) async {
    final id = const Uuid().v4();
    final createdHotel = hotel.copyWith(id: id);
    await connection.query(
      "INSERT INTO $table "
      "VALUES (@id, @name, @phone, @email, @address, @pincode, @city, @country, @rooms, @rating)",
      substitutionValues: createdHotel.toJson(),
    );
    return createdHotel;
  }

  @override
  Future<Hotel?> read(String id) async {
    final result = await connection.mappedResultsQuery(
      "SELECT * FROM $table "
      "WHERE id = '$id'",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data.first;
  }

  @override
  Future<List<Hotel>> readAll() async {
    final result = await connection.mappedResultsQuery(
      "SELECT * FROM $table",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data;
  }

  @override
  Future<Hotel> update(String id, Hotel hotel) async {
    var values = "";
    hotel.toJson().forEach((key, value) {
      if (values != "") values += ', ';
      values += "$key = '$value'";
    });

    await connection.query(
      "UPDATE $table "
      "SET $values "
      "WHERE id = '$id'",
    );
    return hotel;
  }

  @override
  Future<void> delete(String id) async {
    await connection.query(
      "DELETE FROM $table "
      "WHERE id = '$id'",
    );
  }

  Future<List<Hotel>> search(String col, String? query) async {
    final result = await connection.mappedResultsQuery(
      "SELECT * FROM $table "
      "WHERE $col iLIKE '%$query%'",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data;
  }
}
