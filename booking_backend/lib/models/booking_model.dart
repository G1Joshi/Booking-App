// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Booking {
  static String table = Tables.booking;
  int? id;
  String name;
  String checkin;
  String checkout;
  int adults;
  int children;
  int rooms;
  int? room_id;

  Booking({
    this.id,
    required this.name,
    required this.checkin,
    required this.checkout,
    required this.adults,
    required this.children,
    required this.rooms,
    this.room_id,
  });

  Booking copyWith({
    int? id,
    String? name,
    String? checkin,
    String? checkout,
    int? adults,
    int? children,
    int? rooms,
    int? room_id,
  }) {
    return Booking(
      id: id ?? this.id,
      name: name ?? this.name,
      checkin: checkin ?? this.checkin,
      checkout: checkout ?? this.checkout,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      rooms: rooms ?? this.rooms,
      room_id: room_id ?? this.room_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'checkin': checkin,
      'checkout': checkout,
      'adults': adults,
      'children': children,
      'rooms': rooms,
      'room_id': room_id,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      checkin: json['checkin'] as String,
      checkout: json['checkout'] as String,
      adults: json['adults'] as int,
      children: json['children'] as int,
      rooms: json['rooms'] as int,
      room_id: json['room_id'] != null ? json['room_id'] as int : null,
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
      "WHERE room_id = '$id'",
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
      "WHERE room_id = '$id'",
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    String id,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE room_id = '$id'",
    );
  }
}
