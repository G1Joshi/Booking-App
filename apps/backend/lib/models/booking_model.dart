// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class Booking {
  static String table = Tables.bookings;
  int? id;
  String booking_date;
  String checkin;
  String checkout;
  int rooms;
  int guests;
  int? room_id;
  String? user_id;

  Booking({
    required this.booking_date,
    required this.checkin,
    required this.checkout,
    required this.rooms,
    required this.guests,
    this.id,
    this.room_id,
    this.user_id,
  });

  Booking copyWith({
    int? id,
    String? booking_date,
    String? checkin,
    String? checkout,
    int? rooms,
    int? guests,
    int? room_id,
    String? user_id,
  }) {
    return Booking(
      id: id ?? this.id,
      booking_date: booking_date ?? this.booking_date,
      checkin: checkin ?? this.checkin,
      checkout: checkout ?? this.checkout,
      rooms: rooms ?? this.rooms,
      guests: guests ?? this.guests,
      room_id: room_id ?? this.room_id,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'booking_date': booking_date,
      'checkin': checkin,
      'checkout': checkout,
      'rooms': rooms,
      'adults': guests,
      'room_id': room_id,
      'user_id': user_id,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] != null ? json['id'] as int : null,
      booking_date: json['booking_date'] as String,
      checkin: json['checkin'] as String,
      checkout: json['checkout'] as String,
      rooms: json['rooms'] as int,
      guests: json['adults'] as int,
      room_id: json['room_id'] != null ? json['room_id'] as int : null,
      user_id: json['user_id'] != null ? json['user_id'] as String : null,
    );
  }

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
