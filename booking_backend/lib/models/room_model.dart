// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class Room {
  static String table = Tables.rooms;
  int? id;
  String category;
  String? description;
  int price;
  int count;
  int capacity;
  List<String> amenities;
  List<String> room_images;
  int? hotel_id;

  Room({
    required this.category,
    required this.price,
    required this.count,
    required this.capacity,
    required this.amenities,
    required this.room_images,
    this.id,
    this.description,
    this.hotel_id,
  });

  Room copyWith({
    int? id,
    String? category,
    String? description,
    int? price,
    int? count,
    int? capacity,
    List<String>? amenities,
    List<String>? room_images,
    int? hotel_id,
  }) {
    return Room(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      count: count ?? this.count,
      capacity: capacity ?? this.capacity,
      amenities: amenities ?? this.amenities,
      room_images: room_images ?? this.room_images,
      hotel_id: hotel_id ?? this.hotel_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'description': description,
      'price': price,
      'count': count,
      'capacity': capacity,
      'amenities': amenities,
      'room_images': room_images,
      'hotel_id': hotel_id,
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] != null ? json['id'] as int : null,
      category: json['category'] as String,
      description:
          json['description'] != null ? json['description'] as String : null,
      price: json['price'] as int,
      count: json['count'] as int,
      capacity: json['capacity'] as int,
      amenities: List<String>.from(json['amenities'] as List),
      room_images: List<String>.from(json['room_images'] as List),
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

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
