import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/middleware/auth_service_middleware.dart';
import 'package:booking_backend/middleware/booking_service_middleware.dart';
import 'package:booking_backend/middleware/cors_middleware.dart';
import 'package:booking_backend/middleware/db_connection_middleware.dart';
import 'package:booking_backend/middleware/hotel_service_middleware.dart';
import 'package:booking_backend/middleware/review_service_middleware.dart';
import 'package:booking_backend/middleware/room_service_middleware.dart';
import 'package:booking_backend/middleware/token_verification_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  final connection = DBConnection();
  return handler
      .use(requestLogger())
      .use(tokenVerification())
      .use(dbConnection(connection))
      .use(authService(connection))
      .use(hotelService(connection))
      .use(roomService(connection))
      .use(reviewService(connection))
      .use(bookingService(connection))
      .use(cors());
}
