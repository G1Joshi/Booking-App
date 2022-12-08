import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/service/review_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware reviewService(Connection connection) {
  return provider<ReviewService>((_) {
    return ReviewService(connection.getConnection);
  });
}
