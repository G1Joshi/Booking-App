// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Hotel {
  static String table = Tables.hotels;
  int? id;
  String name;
  String description;
  String property_type;
  String chain;
  String category;
  num rating;
  int rooms_starting_price;
  String cover_image;

  Hotel({
    this.id,
    required this.name,
    required this.description,
    required this.property_type,
    required this.chain,
    required this.category,
    required this.rating,
    required this.rooms_starting_price,
    required this.cover_image,
  });

  Hotel copyWith({
    int? id,
    String? name,
    String? description,
    String? property_type,
    String? chain,
    String? category,
    num? rating,
    int? rooms_starting_price,
    String? cover_image,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      property_type: property_type ?? this.property_type,
      chain: chain ?? this.chain,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      rooms_starting_price: rooms_starting_price ?? this.rooms_starting_price,
      cover_image: cover_image ?? this.cover_image,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'property_type': property_type,
      'chain': chain,
      'category': category,
      'rating': rating,
      'rooms_starting_price': rooms_starting_price,
      'cover_image': cover_image,
    };
  }

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      description: json['description'] as String,
      property_type: json['property_type'] as String,
      chain: json['chain'] as String,
      category: json['category'] as String,
      rating: json['rating'] as num,
      rooms_starting_price: json['rooms_starting_price'] as int,
      cover_image: json['cover_image'] as String,
    );
  }

  static Future<int> getId(PostgreSQLConnection connection) async {
    final result = await connection.query(
      "SELECT nextval('${table}_id_seq')",
    );
    final id = result.first.first as int;
    return id;
  }

  static Future<void> create(
    PostgreSQLConnection connection,
    Hotel? data,
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
    await connection.query(
      'INSERT INTO $table ($keys) '
      'VALUES ($values)',
      substitutionValues: data?.toJson(),
    );
  }

  static Future<Hotel> read(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE id = '$id'",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<List<Hotel>> readAll(PostgreSQLConnection connection) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM ${Tables.hotels}',
    );
    final data = result.map((e) => Hotel.fromJson(e[Tables.hotels]!)).toList();
    return data;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Hotel? data,
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
      "WHERE id = '$id'",
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    String id,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE id = '$id'",
    );
  }

  static Future<List<Hotel>> search(
    PostgreSQLConnection connection,
    String col,
    String? query,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE $col iLIKE '%$query%'",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<List<Hotel>> searchByLocality(
    PostgreSQLConnection connection,
    String? locality,
    int distance,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      'WHERE id in ( '
      'SELECT h.hotel_id FROM ${Tables.address} h '
      'JOIN ${Tables.localities} l ON distance(h.latitude, h.longitude, l.latitude, l.longitude) < $distance '
      "WHERE l.name iLIKE '%$locality%' );",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<List<Hotel>> searchByRating(
    PostgreSQLConnection connection,
    num rating,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE rating >= '$rating'",
    );
    final data = result.map((e) => Hotel.fromJson(e[table]!)).toList();
    return data;
  }
}
