// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Reviews {
  static String table = Tables.reviews;
  int? id;
  String name;
  num rating;
  String review;
  List<String> guest_images;
  int? hotel_id;

  Reviews({
    this.id,
    required this.name,
    required this.rating,
    required this.review,
    required this.guest_images,
    required this.hotel_id,
  });

  Reviews copyWith({
    int? id,
    String? name,
    num? rating,
    String? review,
    List<String>? guest_images,
    int? hotel_id,
  }) {
    return Reviews(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      guest_images: guest_images ?? this.guest_images,
      hotel_id: hotel_id ?? this.hotel_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'rating': rating,
      'review': review,
      'guest_images': guest_images,
      'hotel_id': hotel_id,
    };
  }

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] as String,
      rating: json['rating'] as num,
      review: json['review'] as String,
      guest_images: List<String>.from(json['guest_images'] as List<dynamic>),
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    PostgreSQLConnection connection,
    Reviews? data,
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

  static Future<List<Reviews>> read(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((e) => Reviews.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Reviews? data,
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
