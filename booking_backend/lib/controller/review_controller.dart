import 'dart:io';

import 'package:booking_backend/models/general_response.dart';
import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/service/auth_service.dart';
import 'package:booking_backend/service/review_service.dart';
import 'package:dart_frog/dart_frog.dart';

class ReviewController {
  static Future<Response> addReview(RequestContext context, String id) async {
    final authService = context.read<AuthService>();
    final reviewService = context.read<ReviewService>();
    final userId = await authService.getUserID(context.request.headers);
    final review = Review.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await reviewService.create(review, id, userId);
    return Response.json(
      statusCode: HttpStatus.created,
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> updateReview(
    RequestContext context,
    String hotelId,
    String reviewId,
  ) async {
    final reviewService = context.read<ReviewService>();
    final review = await reviewService.read(hotelId, reviewId);
    final updatedReview = Review.fromJson(
      await context.request.json() as Map<String, dynamic>,
    );
    await reviewService.update(
      hotelId,
      reviewId,
      review!.copyWith(
        name: updatedReview.name,
        rating: updatedReview.rating,
        review: updatedReview.review,
        guest_images: updatedReview.guest_images,
      ),
    );
    return Response.json(
      body: GeneralResponse(
        status: true,
      ),
    );
  }

  static Future<Response> deleteReview(
    RequestContext context,
    String hotelId,
    String reviewId,
  ) async {
    final reviewService = context.read<ReviewService>();
    await reviewService.delete(hotelId, reviewId);
    return Response.json(
      body: GeneralResponse(
        status: true,
      ),
    );
  }
}
