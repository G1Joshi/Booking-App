import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/middleware/db_connection_middleware.dart';
import 'package:booking_backend/middleware/hotel_service_middleware.dart';
import 'package:booking_backend/middleware/review_service_middleware.dart';
import 'package:booking_backend/middleware/room_service_middleware.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  final connection = Connection();
  return handler
      .use(requestLogger())
      .use(dbConnection(connection))
      .use(hotelService(connection))
      .use(roomService(connection))
      .use(reviewService(connection));
}
