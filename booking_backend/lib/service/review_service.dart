import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

class ReviewService {
  ReviewService(this.connection);

  final PostgreSQLConnection connection;

  Future<Review> create(RequestContext context, String id) async {
    final review = Review.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    final authService = context.read<AuthService>();
    final userId = await authService.getUserID(context.request.headers);
    final newReview = review.copyWith(hotel_id: int.parse(id), user_id: userId);
    await Review.create(
      connection,
      newReview,
    );
    return newReview;
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
