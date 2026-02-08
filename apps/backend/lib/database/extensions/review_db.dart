// ignore_for_file: non_constant_identifier_names

import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class ReviewDb {
  static String get table => Tables.reviews;

  static Future<void> create(
    Connection connection,
    Review? data,
  ) async {
    var keys = '';
    var values = '';
    _toDatabase(data).keys.forEach((key) {
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
      parameters: _toDatabase(data),
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
    final data = result
        .map((row) => Review.fromJson(row.toColumnMap()))
        .toList();
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
      return _fromDatabase(map);
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

  static Map<String, dynamic> _toDatabase(Review? data) {
    if (data == null) return {};
    return <String, dynamic>{
      'id': data.id,
      'rating': data.rating,
      'review': data.review,
      'guest_images': data.guestImages,
      'hotel_id': data.hotelId,
      'user_id': data.userId,
    };
  }

  static Review _fromDatabase(Map<String, dynamic> map) {
    return Review(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String?,
      profileImage: map['profile_image'] as String?,
      rating: map['rating'] as num,
      review: map['review'] as String,
      guestImages: map['guest_images'] != null
          ? List<String>.from(map['guest_images'] as List<dynamic>)
          : null,
      hotelId: map['hotel_id'] != null ? map['hotel_id'] as int : null,
    );
  }
}
