import 'package:booking_backend/database/query_helper.dart';
import 'package:booking_backend/database/tables.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class ReviewDb {
  static final _crud = CrudDb<Review>(
    table: Tables.reviews,
    fromJson: _fromDatabase,
    toJson: _toDatabase,
  );

  static Future<void> create(Connection connection, Review? data) =>
      _crud.create(connection, data);

  static Future<Review> read(
    Connection connection,
    String hotelId,
    String reviewId,
  ) => _crud.readBy(connection, {
    'hotel_id': hotelId,
    'id': reviewId,
  });

  static Future<List<Review>> readAll(
    Connection connection,
    String id,
  ) => _crud.query(
    connection,
    'SELECT r.id, u.name, u.profile_image, '
    'r.rating, r.review, r.guest_images, r.hotel_id '
    'FROM ${Tables.reviews} r '
    'JOIN ${Tables.users} u ON r.user_id = u.id '
    'WHERE hotel_id = @id',
    {'id': id},
  );

  static Future<void> update(
    Connection connection,
    Review? data,
    String hotelId,
    String reviewId,
  ) => _crud.updateBy(connection, data, {
    'hotel_id': hotelId,
    'id': reviewId,
  });

  static Future<void> delete(
    Connection connection,
    String hotelId,
    String reviewId,
  ) => _crud.deleteBy(connection, {
    'hotel_id': hotelId,
    'id': reviewId,
  });

  static Future<void> deleteAll(Connection connection, String id) =>
      _crud.delete(connection, id);

  static Map<String, dynamic> _toDatabase(Review data) {
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
