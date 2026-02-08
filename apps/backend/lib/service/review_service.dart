import 'package:booking_backend/database/extensions.dart';
import 'package:booking_models/booking_models.dart';
import 'package:postgres/postgres.dart';

class ReviewService {
  ReviewService(this.connection);

  final Connection connection;

  Future<void> create(Review review, String id, String userId) async {
    final newReview = review.copyWith(hotelId: int.parse(id), userId: userId);
    await ReviewDb.create(connection, newReview);
  }

  Future<Review?> read(String hotelId, String reviewId) async {
    final reviews = await ReviewDb.read(connection, hotelId, reviewId);
    return reviews;
  }

  Future<void> update(
    String hotelId,
    String reviewId,
    Review reviews,
  ) async {
    await ReviewDb.update(connection, reviews, hotelId, reviewId);
  }

  Future<void> delete(String hotelId, String reviewId) async {
    await ReviewDb.delete(connection, hotelId, reviewId);
  }
}
