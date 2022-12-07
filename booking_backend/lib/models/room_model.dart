// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Room {
  static String table = Tables.rooms;
  int? id;
  String category;
  String? description;
  int price;
  int count;
  int occupancy;
  List<String> amenities;
  List<String> room_images;
  int? hotel_id;

  Room({
    this.id,
    required this.category,
    this.description,
    required this.price,
    required this.count,
    required this.occupancy,
    required this.amenities,
    required this.room_images,
    required this.hotel_id,
  });

  Room copyWith({
    int? id,
    String? category,
    String? description,
    int? price,
    int? count,
    int? occupancy,
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
      occupancy: occupancy ?? this.occupancy,
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
      'occupancy': occupancy,
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
      occupancy: json['occupancy'] as int,
      amenities: List<String>.from(json['amenities'] as List),
      room_images: List<String>.from(json['room_images'] as List),
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    PostgreSQLConnection connection,
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
    await connection.query(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }

  static Future<List<Room>> read(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((e) => Room.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Room? data,
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