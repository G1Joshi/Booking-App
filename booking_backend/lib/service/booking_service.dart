import 'package:booking_backend/models/hotels_model.dart';
import 'package:postgres/postgres.dart';

class BookingService {
  BookingService(this.connection);

  final PostgreSQLConnection connection;

  Future<Booking> create(Booking booking, String id) async {
    await Booking.create(connection, booking.copyWith(room_id: int.parse(id)));
    return booking;
  }

  Future<Booking?> read(String roomId) async {
    final booking = await Booking.read(connection, roomId);
    return booking;
  }

  Future<Booking> update(String roomId, Booking booking) async {
    await Booking.update(connection, booking, roomId);
    return booking;
  }

  Future<void> delete(String roomId) async {
    await Booking.delete(connection, roomId);
  }
}
