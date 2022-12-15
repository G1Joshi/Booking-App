// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of './hotels_model.dart';

class Review {
  static String table = Tables.reviews;
  int? id;
  String name;
  num rating;
  String review;
  List<String> guest_images;
  int? hotel_id;

  Review({
    this.id,
    required this.name,
    required this.rating,
    required this.review,
    required this.guest_images,
    this.hotel_id,
  });

  Review copyWith({
    int? id,
    String? name,
    num? rating,
    String? review,
    List<String>? guest_images,
    int? hotel_id,
  }) {
    return Review(
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

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
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
    Review? data,
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

  static Future<Review> read(
    PostgreSQLConnection connection,
    String hotelId,
    String reviewId,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
    );
    final data = result.map((e) => Review.fromJson(e[table]!)).toList();
    return data.first;
  }

  static Future<List<Review>> readAll(
    PostgreSQLConnection connection,
    String id,
  ) async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((e) => Review.fromJson(e[table]!)).toList();
    return data;
  }

  static Future<void> update(
    PostgreSQLConnection connection,
    Review? data,
    String hotelId,
    String reviewId,
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

    await connection.query(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
    );
  }

  static Future<void> delete(
    PostgreSQLConnection connection,
    String hotelId,
    String reviewId,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
    );
  }

  static Future<void> deleteAll(
    PostgreSQLConnection connection,
    String id,
  ) async {
    await connection.query(
      'DELETE FROM $table '
      "WHERE hotel_id = '$id'",
    );
  }
}
