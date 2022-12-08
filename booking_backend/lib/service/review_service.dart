import 'package:booking_backend/models/hotels_model.dart';
import 'package:postgres/postgres.dart';

class ReviewService {
  ReviewService(this.connection);

  final PostgreSQLConnection connection;

  Future<Review> create(Review review, String id) async {
    await Review.create(connection, review.copyWith(hotel_id: int.parse(id)));
    return review;
  }

  Future<Review?> read(String hotelId, String reviewId) async {
    final reviews = await Review.read(connection, hotelId, reviewId);
    return reviews;
  }

  Future<Review> update(
    String hotelId,
    String reviewId,
    Review reviews,
  ) async {
    await Review.update(connection, reviews, hotelId, reviewId);
    return reviews;
  }

  Future<void> delete(String hotelId, String reviewId) async {
    await Review.delete(connection, hotelId, reviewId);
  }
}
