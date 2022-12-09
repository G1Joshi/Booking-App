import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/service/booking_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware bookingService(Connection connection) {
  return provider<BookingService>((_) {
    return BookingService(connection.getConnection);
  });
}
