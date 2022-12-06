// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Booking {
  static String table = Tables.booking;
  int? id;
  String checkin;
  String checkout;
  String cancellation;
  int? hotel_id;

  Booking({
    this.id,
    required this.checkin,
    required this.checkout,
    required this.cancellation,
    this.hotel_id,
  });

  Booking copyWith({
    int? id,
    String? checkin,
    String? checkout,
    String? cancellation,
    int? hotel_id,
  }) {
    return Booking(
      id: id ?? this.id,
      checkin: checkin ?? this.checkin,
      checkout: checkout ?? this.checkout,
      cancellation: cancellation ?? this.cancellation,
      hotel_id: hotel_id ?? this.hotel_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'checkin': checkin,
      'checkout': checkout,
      'cancellation': cancellation,
      'hotel_id': hotel_id,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] != null ? json['id'] as int : null,
      checkin: json['checkin'].toString(),
      checkout: json['checkout'].toString(),
      cancellation: json['cancellation'] as String,
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    PostgreSQLConnection connection,
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
    await connection.query(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }

  static Future<Booking> read(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((e) => Booking.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Booking? data,
    String id,
  ) async {
    var values = '';
    data?.toJson().forEach((key, value) {
      if (values != '') values += ', ';
      values += "$key = '$value'";
    });

    await connection.query(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$id'",
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    String id,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE hotel_id = '$id'",
    );
  }
}
