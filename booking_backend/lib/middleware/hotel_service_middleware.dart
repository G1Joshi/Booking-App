import 'package:booking_backend/database/connection.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';

Middleware hotelService(Connection connection) {
  return provider<HotelService>((_) {
    return HotelService(connection.getConnection);
  });
}
