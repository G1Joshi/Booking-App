// ignore_for_file: non_constant_identifier_names, sort_constructors_first

part of 'models.dart';

class Review {
  static String table = Tables.reviews;
  int? id;
  String? name;
  String? profile_image;
  num rating;
  String review;
  List<String>? guest_images;
  int? hotel_id;
  String? user_id;

  Review({
    required this.rating,
    required this.review,
    this.id,
    this.name,
    this.profile_image,
    this.guest_images,
    this.hotel_id,
    this.user_id,
  });

  Review copyWith({
    int? id,
    String? name,
    String? profile_image,
    num? rating,
    String? review,
    List<String>? guest_images,
    int? hotel_id,
    String? user_id,
  }) {
    return Review(
      id: id ?? this.id,
      name: name ?? this.name,
      profile_image: profile_image ?? this.profile_image,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      guest_images: guest_images ?? this.guest_images,
      hotel_id: hotel_id ?? this.hotel_id,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profile_image': profile_image,
      'rating': rating,
      'review': review,
      'guest_images': guest_images,
      'hotel_id': hotel_id,
    };
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'rating': rating,
      'review': review,
      'guest_images': guest_images,
      'hotel_id': hotel_id,
      'user_id': user_id,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] != null ? json['id'] as int : null,
      rating: json['rating'] as num,
      review: json['review'] as String,
      guest_images: json['guest_images'] != null
          ? List<String>.from(json['guest_images'] as List<dynamic>)
          : [],
      hotel_id: json['hotel_id'] != null ? json['hotel_id'] as int : null,
      user_id: json['user_id'] != null ? json['user_id'] as String : null,
    );
  }

  factory Review.fromDatabase(
    Map<String, dynamic> review,
    Map<String, dynamic> user,
  ) {
    return Review(
      id: review['id'] != null ? review['id'] as int : null,
      name: user['name'] != null ? user['name'] as String : null,
      profile_image: user['profile_image'] != null
          ? user['profile_image'] as String
          : null,
      rating: review['rating'] as num,
      review: review['review'] as String,
      guest_images: review['guest_images'] != null
          ? List<String>.from(review['guest_images'] as List<dynamic>)
          : [],
      hotel_id: review['hotel_id'] != null ? review['hotel_id'] as int : null,
    );
  }

  static Future<void> create(
    Connection connection,
    Review? data,
  ) async {
    var keys = '';
    var values = '';
    data?.toDatabase().keys.forEach((key) {
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
      parameters: data?.toDatabase(),
    );
  }

  static Future<Review> read(
    Connection connection,
    String hotelId,
    String reviewId,
  ) async {
    final result = await connection.execute(
      'SELECT * FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
    );
    final data =
        result.map((row) => Review.fromJson(row.toColumnMap())).toList();
    return data.first;
  }

  static Future<List<Review>> readAll(
    Connection connection,
    String id,
  ) async {
    final result = await connection.execute(
      'SELECT r.id, u.name, u.profile_image, r.rating, r.review, r.guest_images, r.hotel_id '
      'FROM $table r '
      'JOIN ${Tables.users} u ON r.user_id = u.id '
      "WHERE hotel_id = '$id'",
    );
    final data = result.map((row) {
      final map = row.toColumnMap();
      return Review.fromDatabase(map, map);
    }).toList();
    return data;
  }

  static Future<void> update(
    Connection connection,
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

    await connection.execute(
      'UPDATE $table '
      'SET $values '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
    );
  }

  static Future<void> delete(
    Connection connection,
    String hotelId,
    String reviewId,
  ) async {
    await connection.execute(
      'DELETE FROM $table '
      "WHERE hotel_id = '$hotelId' AND id = '$reviewId'",
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
