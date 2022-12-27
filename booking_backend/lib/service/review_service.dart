import 'package:booking_backend/models/models.dart';
import 'package:postgres/postgres.dart';

class ReviewService {
  ReviewService(this.connection);

  final PostgreSQLConnection connection;

  Future<void> create(Review review, String id, String userId) async {
    final newReview = review.copyWith(hotel_id: int.parse(id), user_id: userId);
    await Review.create(connection, newReview);
  }

  Future<Review?> read(String hotelId, String reviewId) async {
    final reviews = await Review.read(connection, hotelId, reviewId);
    return reviews;
  }

  Future<void> update(
    String hotelId,
    String reviewId,
    Review reviews,
  ) async {
    await Review.update(connection, reviews, hotelId, reviewId);
  }

  Future<void> delete(String hotelId, String reviewId) async {
    await Review.delete(connection, hotelId, reviewId);
  }
}
